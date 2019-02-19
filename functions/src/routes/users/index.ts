'use strict';

import { Router } from "express";
import { AuthRequest } from "../../interfaces";
import { Scope } from "../../enums/scope";
import UserValidator from "./users.validator"
import UserController from "./users.controller"
import Auth from "../auth"
import * as functions from 'firebase-functions';
import * as admin from "firebase-admin";
const router = Router();

/**
 * restrict routers
 */

// this endpoint do not need a scope
router.post('/', UserValidator().create(),
    (req: AuthRequest, res, next) => {
        UserController().create(req, res).catch(next);
    });

router.get('/get/profile', Auth(),
    (req: AuthRequest, res, next) => {
        UserController().profile(req, res).catch(next);
    });

router.put('/:id', UserValidator().update(), Auth(Scope.ADMIN),
    (req: AuthRequest, res, next) => {
        UserController().update(req, res).catch(next);
    });

router.put('/', UserValidator().updateLogged(), Auth(),
    (req: AuthRequest, res, next) => {
        UserController().updateLogged(req, res).catch(next);
    });

router.put('/status/:id', UserValidator().changeStatus(), Auth(Scope.ADMIN),
    (req: AuthRequest, res, next) => {
        UserController().changeStatus(req, res).catch(next);
    });

router.put('/scope/:id', UserValidator().changeScope(), Auth(Scope.ADMIN),
    (req: AuthRequest, res, next) => {
        UserController().changeScope(req, res).catch(next);
    });

/**
 * public routers
 */
router.get('/email/:email',
    (req, res, next) => {
        UserController().isEmailAvailable(req, res).catch(next);
    });

    router.get('/hif',  
    (req, res, next) =>  {
        UserController().hi(req, res).catch(next);
    });



router.post('/customAuth', 
(req, res, next) =>  {

    functions.firestore
    .document('fichas/{fichaId}').onCreate((snap, context) => {
        const db = admin.firestore();

        const ficha = snap.data();
        const medicoRef = db.doc(`users/${ficha.medico}`);

        return db.runTransaction(async (transaction) => {
            const docMedico = await transaction.get(medicoRef);
            const qtdFichas = (docMedico.data().qtdFichas || 0) + 1;

            transaction
                .update(medicoRef, { qtdFichas: qtdFichas })
                .update(snap.ref, { numero: qtdFichas });
        })
    })
    res.json({ "Asdf":"asdfdfd" });


    console.log(req.body)
    UserController().customAuth(req, res).catch(next);
});

export default router;