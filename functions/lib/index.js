'use strict';
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const app_1 = require("./app");
/**
 * API
 */
exports.api = functions.https.onRequest(app_1.default);
exports.hello = functions.https.onRequest((req, res) => {
    res.json({ "Asdf": "asdf" });
});
/**
 * Trigger que incrementa o contador de fichas por usuário
 */
exports.count = functions.firestore
    .document('fichas/{fichaId}').onCreate((snap, context) => {
    const db = admin.firestore();
    const ficha = snap.data();
    const medicoRef = db.doc(`users/${ficha.medico}`);
    return db.runTransaction((transaction) => __awaiter(this, void 0, void 0, function* () {
        const docMedico = yield transaction.get(medicoRef);
        const qtdFichas = (docMedico.data().qtdFichas || 0) + 1;
        transaction
            .update(medicoRef, { qtdFichas: qtdFichas })
            .update(snap.ref, { numero: qtdFichas });
    }));
});
