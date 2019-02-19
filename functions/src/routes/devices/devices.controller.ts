'use strict';

import * as admin from "firebase-admin";
import { Request, Response } from "express";
import { AuthRequest } from "../../interfaces";
import { Scope } from "../../enums/scope";
import * as Boom from 'boom';
import axios from 'axios'

const token =
  "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjY3ZTRkYjEzMjU4NzUzM2QxYjZjYjA3Y2U5OGJmNzZjMjhhMzM2Yjk0YzBmMzg0MzRiMTUxOTJlMDA2MDBjNDQ5MjQ3YzU0MjRmMmNmZmM0In0.eyJhdWQiOiIzIiwianRpIjoiNjdlNGRiMTMyNTg3NTMzZDFiNmNiMDdjZTk4YmY3NmMyOGEzMzZiOTRjMGYzODQzNGIxNTE5MmUwMDYwMGM0NDkyNDdjNTQyNGYyY2ZmYzQiLCJpYXQiOjE1NDk4NTM5MDgsIm5iZiI6MTU0OTg1MzkwOCwiZXhwIjoxNTgxMzg5OTA4LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.dml5K0kWint7BMjwlFXUEuL0bnGMFUuBGty06kHUgA_Wvq7P9yaITJuFcgSxsDDkg7c9npXUcTMiQBMObPHCPB9EOZD39jsOgCbGoKeZuH5VqbEGK8xP2fcpY4lDyozr3ldTsgctRNrjIlRLP9Y-fqN5jDez_wptymWoYVfNmuR_YV1tiOlTFYj2qbc7UEcbJj7VzPxSJGGFESGuOdXyhONTcR91lw08Judw9cMSkvHAmWueFoCFjM3lM95b07ojlkyVeVRzDbDkag-VPAYd6sIelpOcJamn84wk98id0x2ht422yTPPrCSa6Fpxu132gWONqg-JaazQWfVFr5_ClFftQnR6rXrJS60WSyGzX8_cvpPnX5Bru4vgLa0SD7e7k_azYP3dEjmZF2dkOt7ayyF4iRsq7jlfspczkkrD4y1pfGxKXfpeS2KKwqz74QUKRK98jXClHPCSGeBtxuKemxtUWilW9nt405fyZMFAUHANGTFg86XdIXm_ydpLDpjtp4x-hwBUJwUYJctHObjpd4r1tmyFALTWD47Y5DAz353VH-N3fmixU1wMCHOAR26EHftLTmSFL6hlGBQuORVpP_vmNvEXGJ5Toyrvtf3P4tsrRhN5AVrGc7o7Ea6IfhNvwvZHa7C3Pdw2fqdX5SrHVQWq0ei8LW3tR0A2BUqcCIk";
const snipeit = axios.create({
  baseURL: "http://47.219.174.153:8085/api/v1",
  timeout: 2000,
  headers: { Authorization: "Bearer " + token }
});



class DevicesController {
     async checkoutDevice(snipeId: string, device: any) {
console.log(device['id'])
        const checkout = await snipeit.post(
          "/hardware/" + device['id']+ "/checkout",
          {
            assigned_user: snipeId,
            checkout_to_type: "user"
          }
        );
        if (checkout.data.status !== "success") {
          console.log(checkout.data);
          return false;
        } else {
          return true;
        }
      }
       async  checkinDevice(snipeId: string, device: any) {
        const checkin = await snipeit.post(
          "/hardware/" + device + "/checkin",
          {
            note: 'checkindevice function',
            location_id: 2
          }
        );
        if (checkin.data.status !== "success") {
          console.log(checkin.data);
          return false;
        } else {
          return true;
        }
      }
       async  updateDeviceInFirestore(deviceId: string, userId: any) {
        try {
          admin.firestore().collection("devices").doc(deviceId).update({
            "owner": userId,
            "lastUpdateDate": Date.now()
          })
        } catch (err) {
          return false
        }
        return true
      }
      
       async  getDeviceFromFirestore(deviceId: any) {
        const docRef =  admin.firestore().collection("devices").doc(deviceId);
        return await docRef.get()
      }


    async create(req: AuthRequest, res: Response) {
        const user = req.body;

        try {
            // Seta o escopo do usuário como user
            user.scope = { admin: false, user: true };

            // Remove máscara do cpf
            user.cpf = user.cpf.replace(/\D/g, '');

            // Remove máscara do telefone
            user.telefone = user.telefone.replace(/\D/g, '');

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
            }

            // Cria o dado na storage
            await admin.firestore().collection('users').doc(firebaseUser.uid).create(data);

            // Cria o escopo do usuário no firebase
            await admin.auth().setCustomUserClaims(firebaseUser.uid, { scope: data.scope });

            res.json({ data });
        } catch (error) {
            if (error.code === "auth/email-already-exists") {
                throw Boom.conflict('Usuário já existe');
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

    async addUsertoDevice(req: AuthRequest, res: Response) {
        const user = await admin.firestore().collection('users').doc(req.credentials.uid).get();

        const data = user.data();

        // Remove o escopo da requisição
        delete data.scope;

        res.json(data);
    }

    async setOwner(req: AuthRequest, res: Response) {
        const user = await admin.firestore().collection('users').doc(req.credentials.uid).get();

        const data = user.data();

        // Remove o escopo da requisição
        delete data.scope;

        res.json(data);
    }

    async removeUser(req: AuthRequest, res: Response) {
        const user = await admin.firestore().collection('users').doc(req.credentials.uid).get();

        const data = user.data();

        // Remove o escopo da requisição
        delete data.scope;

        res.json(data);
    }

    async addLocationUpdate(req: AuthRequest, res: Response) {
        // const user = await admin.firestore().collection('users').doc(req.credentials.uid).get();

        // const data = user.data();

        // Remove o escopo da requisição
        // delete data.scope;

        // res.json(data);
        res.json('hai2u');
    }


    async checkIn(req: AuthRequest, res: Response) {
        const uid = req.params.id;
        const body = req.body;

        await admin.firestore().collection('users').doc(uid).get();

        const toUpdateFirebase = {
            disabled: body.status === 0 ? true : false
        };

        // Seta o status do usuário no firebase
        await admin.auth().updateUser(uid, toUpdateFirebase);

        // Seta o status do usuário na storage
        await admin.firestore().collection('users').doc(uid).update({ status: body.status });

        body.id = uid;

        res.json(body);
    }

    async checkOut(req: AuthRequest, res: Response) {
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

        await admin.firestore().collection('users').doc(uid).get();

        // Seta o scope do usuário no firebase
        await admin.auth().setCustomUserClaims(uid, { scope: body.scope });

        // Seta o scope do usuário na storage
        await admin.firestore().collection('users').doc(uid).update({ scope: body.scope });

        body.id = uid;

        res.json(body);
    }

    async isDeviceDeployable(req: Request, res: Response) {
        const email = req.params.email;
        let isAvailable: boolean;

        try {
            // Verifica se o e-mail passado está disponível para cadastro
            await admin.auth().getUserByEmail(email);
            isAvailable = false;
        } catch (error) {
            switch (error.code) {
                case 'auth/user-not-found':
                    isAvailable = true;
                    break;
                case 'auth/invalid-email':
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

function init(): DevicesController {
    return new DevicesController();
}

export default init;