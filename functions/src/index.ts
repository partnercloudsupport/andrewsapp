"use strict";

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import ServiceItem from "./interfaces/service.item";
import app from "./app";
import axios from "axios";
import Spreadsheet from "./services/spreadsheet";
const jsonDiff = require("json-diff");

/**
 * API
 */
export const api = functions.https.onRequest(app);

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
export const serviceItemCreate = functions.firestore
  .document("workorders/{workorderId}/serviceItems/{serviceItemId}")
  .onCreate((snap, context) => {
    return Spreadsheet().updateSpreadsheet(snap);
    //  return item;
    //  return Spreadsheet().appendRow(item);
  });
const WEBHOOK_URL =
  "https://script.google.com/d/11RcQ8a26oCqLSqmhm1qWQX0mWJUhHbk-h6aiMbfn2KaQsTiZmVtS5BDA/exec";

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
  .onCreate(async (snap, context) => {
    var r = (await axios.post(WEBHOOK_URL, snap.data())) as any;
    if (r.response > 400) {
      throw new Error(`HTTP Error: ${r.statusCode}`);
    }
    console.log("SUCCESS! Posted", snap.ref);
  });
