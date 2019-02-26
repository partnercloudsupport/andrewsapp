"use strict";
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
const app_1 = require("./app");
const axios_1 = require("axios");
const spreadsheet_1 = require("./services/spreadsheet");
const jsonDiff = require("json-diff");
/**
 * API
 */
exports.api = functions.https.onRequest(app_1.default);
// export const hello = functions.https.onRequest(async (req, res) => {
//   const firebaseUser = await admin.auth().createUser({
//     email: "xxx@xxx.com",
//     password: "asdfasdf",
//     disabled: false
//   });
//   res.json({ Asdf: "asdfdfdxxx" });
// });
/**
 * Trigger que incrementa o contador de fichas por usuário
 */
// export const count = functions.firestore
//   .document("fichas/{fichaId}")
//   .onCreate((snap, context) => {
//     const db = admin.firestore();
//     const ficha = snap.data();
//     const medicoRef = db.doc(`users/${ficha.medico}`);
//     return db.runTransaction(async transaction => {
//       const docMedico = await transaction.get(medicoRef);
//       const qtdFichas = (docMedico.data().qtdFichas || 0) + 1;
//       transaction
//         .update(medicoRef, { qtdFichas: qtdFichas })
//         .update(snap.ref, { numero: qtdFichas });
//     });
//   });
/**
 * serviceItemCreate({workorders: "new"}, {params: {group: "workorders/serviceItems", id: 123}})
 */
exports.serviceItemCreate = functions.firestore
    .document("test/{workorderId}/serviceItems/{serviceItemId}")
    .onCreate((snap, context) => {
    return spreadsheet_1.default().updateSpreadsheet(snap);
    //  return item;
    //  return Spreadsheet().appendRow(item);
});
const WEBHOOK_URL = "https://script.google.com/d/11RcQ8a26oCqLSqmhm1qWQX0mWJUhHbk-h6aiMbfn2KaQsTiZmVtS5BDA/exec";
// Reads the content of the node that triggered the function and sends it to the registered Webhook
// URL.
exports.serviceItem_updated = functions.firestore
    .document("test/{workorderId}/serviceItems/{serviceItemId}")
    .onUpdate((change, context) => {
    const newValue = change.after.data();
    // ...or the previous value before this update
    const previousValue = change.before.data();
    // access a particular field as you would any JS property
    const diff = jsonDiff.diffString(previousValue, newValue);
    console.log(diff);
});
exports.serviceItem_created = functions.firestore
    .document("test/{workorderId}/serviceItems/{serviceItemId}")
    .onCreate((snap, context) => __awaiter(this, void 0, void 0, function* () {
    var r = (yield axios_1.default.post(WEBHOOK_URL, snap.data()));
    if (r.response > 400) {
        throw new Error(`HTTP Error: ${r.statusCode}`);
    }
    console.log("SUCCESS! Posted", snap.ref);
}));
