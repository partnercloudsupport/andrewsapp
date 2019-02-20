"use strict";

import * as admin from "firebase-admin";
import { Request, Response } from "express";
import { AuthRequest } from "../../interfaces";
import { Scope } from "../../enums/scope";
import * as Boom from "boom";
import DevicesController from "../devices/devices.controller";
import { checkDistance } from "./utils";
import axios from "axios";

const token =
  "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjY3ZTRkYjEzMjU4NzUzM2QxYjZjYjA3Y2U5OGJmNzZjMjhhMzM2Yjk0YzBmMzg0MzRiMTUxOTJlMDA2MDBjNDQ5MjQ3YzU0MjRmMmNmZmM0In0.eyJhdWQiOiIzIiwianRpIjoiNjdlNGRiMTMyNTg3NTMzZDFiNmNiMDdjZTk4YmY3NmMyOGEzMzZiOTRjMGYzODQzNGIxNTE5MmUwMDYwMGM0NDkyNDdjNTQyNGYyY2ZmYzQiLCJpYXQiOjE1NDk4NTM5MDgsIm5iZiI6MTU0OTg1MzkwOCwiZXhwIjoxNTgxMzg5OTA4LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.dml5K0kWint7BMjwlFXUEuL0bnGMFUuBGty06kHUgA_Wvq7P9yaITJuFcgSxsDDkg7c9npXUcTMiQBMObPHCPB9EOZD39jsOgCbGoKeZuH5VqbEGK8xP2fcpY4lDyozr3ldTsgctRNrjIlRLP9Y-fqN5jDez_wptymWoYVfNmuR_YV1tiOlTFYj2qbc7UEcbJj7VzPxSJGGFESGuOdXyhONTcR91lw08Judw9cMSkvHAmWueFoCFjM3lM95b07ojlkyVeVRzDbDkag-VPAYd6sIelpOcJamn84wk98id0x2ht422yTPPrCSa6Fpxu132gWONqg-JaazQWfVFr5_ClFftQnR6rXrJS60WSyGzX8_cvpPnX5Bru4vgLa0SD7e7k_azYP3dEjmZF2dkOt7ayyF4iRsq7jlfspczkkrD4y1pfGxKXfpeS2KKwqz74QUKRK98jXClHPCSGeBtxuKemxtUWilW9nt405fyZMFAUHANGTFg86XdIXm_ydpLDpjtp4x-hwBUJwUYJctHObjpd4r1tmyFALTWD47Y5DAz353VH-N3fmixU1wMCHOAR26EHftLTmSFL6hlGBQuORVpP_vmNvEXGJ5Toyrvtf3P4tsrRhN5AVrGc7o7Ea6IfhNvwvZHa7C3Pdw2fqdX5SrHVQWq0ei8LW3tR0A2BUqcCIk";
const snipeit = axios.create({
  baseURL: "http://47.219.174.153:8085/api/v1",
  timeout: 2000,
  headers: { Authorization: "Bearer " + token }
});

async function _updateUserInFirestore(deviceId: any, userId: string) {
  console.log(userId);
  try {
    admin
      .firestore()
      .collection("employees")
      .doc(userId)
      .update({
        currentDevice: deviceId,
        lastUpdateDate: Date.now()
      });
  } catch (err) {
    return false;
  }
  return true;
}

async function _authenticate(
  deviceId: string,
  userId: string,
  snipeId: string
) {
  let device: any = await snipeit.get("/hardware/byserial/" + deviceId);
  device = device.data.rows[0];
  var did = device["id"];
  console.log(did);
  // console.log(device['status_label']['id']);
  if (device["status_label"]["id"] !== "1")
    await DevicesController().checkinDevice(snipeId, device["id"]);

  const checkoutResult = await DevicesController().checkoutDevice(
    snipeId,
    device
  );
  console.log(checkoutResult);
  if (!checkoutResult) return false;

  const updateResult = await DevicesController().updateDeviceInFirestore(
    deviceId,
    userId
  );
  console.log(updateResult);
  if (!updateResult) return false;

  const updateUser = await _updateUserInFirestore(deviceId, userId);
  if (!updateUser) return false;
  return true;
}

async function _logOut(deviceId: string, userId: string, snipeId: string) {
  const checkInResult = await DevicesController().checkinDevice(
    snipeId,
    deviceId
  );
  console.log(checkInResult);
  if (!checkInResult) return false;

  const updateResult = await DevicesController().updateDeviceInFirestore(
    deviceId,
    null
  );
  console.log(updateResult);
  if (!updateResult) return false;

  const updateUser = await _updateUserInFirestore(null, userId);
  if (!updateUser) return false;
  return true;
}

async function logOut(req: any, res: any) {
  const userId = req.body.userId;
  const deviceId = req.body.deviceId;
  const snipeId = req.body.snipeId;

  if (!userId || !deviceId || !snipeId || req.method !== "POST") {
    return res.sendStatus(300, "didnt have all yo  shit");
  }

  const device = await DevicesController().getDeviceFromFirestore(deviceId);
  let valid = await checkDistance(device);
  if (!valid) {
    return res.sendStatus(300, "couldnt get device"); // Invalid username/password
  }
  valid = await _logOut(deviceId, userId, snipeId);
  if (!valid) {
    return res.sendStatus(401); // Invalid username/password
  }

  return res.sendStatus(200);
}

class UsersController {
  async customAuth(req: any, res: Response) {
    const userId = req.body.userId;
    const deviceId = req.body.deviceId;
    const snipeId = req.body.snipeId;

    if (!userId || !deviceId || !snipeId || req.method !== "POST") {
      res.json(false);
    }
    const valid = await _authenticate(deviceId, userId, snipeId);
    if (!valid) {

        res.json(valid); // Invalid username/password
    }
    // const firebaseToken = await admin.auth().createCustomToken(userId);
    res.json(valid);
    //return deviceId;
    // res.json(deviceId) // Invalid username/password
  }

  async create(req: AuthRequest, res: Response) {
    const user = req.body;

    try {
      // Seta o escopo do usuário como user
      user.scope = { admin: false, user: true };

      // Remove máscara do cpf
      user.cpf = user.cpf.replace(/\D/g, "");

      // Remove máscara do telefone
      user.telefone = user.telefone.replace(/\D/g, "");

      // Cria o usuário no firebase authentication
      const firebaseUser = await admin.auth().createUser({
        email: user.email,
        password: user.senha,
        disabled: false
      });

      // Pega o id do usuário criado no firebase authentication
      user.id = firebaseUser.uid;

      // Garantindo que só seja salvo no banco os dados que são necessários
      const data = {
        id: user.id,
        email: user.email,
        nome: user.nome,
        cpf: user.cpf,
        data_nascimento: user.data_nascimento,
        telefone: user.telefone,
        scope: user.scope,
        status: 1
      };

      // Cria o dado na storage
      await admin
        .firestore()
        .collection("users")
        .doc(firebaseUser.uid)
        .create(data);

      // Cria o escopo do usuário no firebase
      await admin
        .auth()
        .setCustomUserClaims(firebaseUser.uid, { scope: data.scope });

      res.json({ data });
    } catch (error) {
      if (error.code === "auth/email-already-exists") {
        throw Boom.conflict("Usuário já existe");
      }

      if (error.code === "auth/invalid-password") {
        throw Boom.badRequest(error.message);
      }

      if (user && user.id) {
        await admin.auth().deleteUser(user.id);
      }
      throw error;
    }
  }

  async profile(req: AuthRequest, res: Response) {
    const user = await admin
      .firestore()
      .collection("users")
      .doc(req.credentials.uid)
      .get();

    const data = user.data();

    // Remove o escopo da requisição
    delete data.scope;

    res.json(data);
  }

  async update(req: AuthRequest, res: Response) {
    const uid = req.params.id;
    const user = req.body;

    await admin
      .firestore()
      .collection("users")
      .doc(uid)
      .get();

    // Remove máscara do cpf
    user.cpf = user.cpf.replace(/\D/g, "");

    // Remove máscara do telefone
    user.telefone = user.telefone.replace(/\D/g, "");

    // Garantindo que só seja salvo no banco os dados que são necessários
    const data = {
      nome: user.nome,
      cpf: user.cpf,
      data_nascimento: user.data_nascimento,
      telefone: user.telefone
    };

    // Atualiza email e/ou senha no firebase authentication, caso seja passado na requisição
    const toUpdateFirebase = {};

    if (user.email) {
      toUpdateFirebase["email"] = user.email;
      data["email"] = user.email;
    }

    // Seta o dado no Firebase Auth
    if (JSON.stringify(toUpdateFirebase) !== "{}") {
      await admin.auth().updateUser(uid, toUpdateFirebase);
    }

    // Seta o dado na storage
    await admin
      .firestore()
      .collection("users")
      .doc(uid)
      .update(data);

    res.json({ data });
  }

  async updateLogged(req: AuthRequest, res: Response) {
    const uid = req.credentials.uid;
    const user = req.body;

    await admin
      .firestore()
      .collection("users")
      .doc(uid)
      .get();

    // Remove máscara do cpf
    user.cpf = user.cpf.replace(/\D/g, "");

    // Remove máscara do telefone
    user.telefone = user.telefone.replace(/\D/g, "");

    // Garantindo que só seja salvo no banco os dados que são necessários
    const data = {
      nome: user.nome,
      cpf: user.cpf,
      data_nascimento: user.data_nascimento,
      telefone: user.telefone
    };

    // Atualiza email e/ou senha no firebase authentication, caso seja passado na requisição
    const toUpdateFirebase = {};

    if (user.email) {
      toUpdateFirebase["email"] = user.email;
      data["email"] = user.email;
    }

    if (user.senha) {
      toUpdateFirebase["password"] = user.senha;
    }

    // Seta o dado no Firebase Auth
    if (JSON.stringify(toUpdateFirebase) !== "{}") {
      await admin.auth().updateUser(uid, toUpdateFirebase);
    }

    // Seta o dado na storage
    await admin
      .firestore()
      .collection("users")
      .doc(uid)
      .update(data);

    res.json({ data });
  }

  async changeStatus(req: AuthRequest, res: Response) {
    const uid = req.params.id;
    const body = req.body;

    await admin
      .firestore()
      .collection("users")
      .doc(uid)
      .get();

    const toUpdateFirebase = {
      disabled: body.status === 0 ? true : false
    };

    // Seta o status do usuário no firebase
    await admin.auth().updateUser(uid, toUpdateFirebase);

    // Seta o status do usuário na storage
    await admin
      .firestore()
      .collection("users")
      .doc(uid)
      .update({ status: body.status });

    body.id = uid;

    res.json(body);
  }

  async changeScope(req: AuthRequest, res: Response) {
    const uid = req.params.id;
    let body = req.body;

    // User Scope
    switch (body.scope) {
      case Scope.ADMIN:
        body.scope = { admin: true, user: false };
        break;
      case Scope.USER:
        body.scope = { admin: false, user: true };
        break;
      default:
        body.scope = { admin: false, user: false };
        break;
    }

    await admin
      .firestore()
      .collection("users")
      .doc(uid)
      .get();

    // Seta o scope do usuário no firebase
    await admin.auth().setCustomUserClaims(uid, { scope: body.scope });

    // Seta o scope do usuário na storage
    await admin
      .firestore()
      .collection("users")
      .doc(uid)
      .update({ scope: body.scope });

    body.id = uid;

    res.json(body);
  }
  async hi(req: Request, res: Response) {
    admin
      .firestore()
      .collection("test")
      .doc()
      .set({ asdf: "asdf" });
    console.log("test");

    res.status(200).json({ hai2u: "uxxx" });
  }
  async isEmailAvailable(req: Request, res: Response) {
    const email = req.params.email;
    let isAvailable: boolean;

    try {
      // Verifica se o e-mail passado está disponível para cadastro
      await admin.auth().getUserByEmail(email);
      isAvailable = false;
    } catch (error) {
      switch (error.code) {
        case "auth/user-not-found":
          isAvailable = true;
          break;
        case "auth/invalid-email":
          throw Boom.badRequest(error.message);
          break;
        default:
          throw error;
          break;
      }
    }

    res.status(isAvailable ? 200 : 409).json({ email });
  }
}

function init(): UsersController {
  return new UsersController();
}

export default init;
