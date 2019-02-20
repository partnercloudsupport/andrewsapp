"use strict";

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import ServiceItem from './interfaces/service.item'
import app from "./app";
import Spreadsheet from './services/spreadsheet'
/**
 * API
 */
export const api = functions.https.onRequest(app);

export const hello = functions.https.onRequest(async (req, res) => {
  const firebaseUser = await admin.auth().createUser({
    email: "xxx@xxx.com",
    password: "asdfasdf",
    disabled: false
  });

  res.json({ Asdf: "asdfdfdxxx" });
});

/**
 * Trigger que incrementa o contador de fichas por usuário
 */
export const count = functions.firestore
  .document("fichas/{fichaId}")
  .onCreate((snap, context) => {
    const db = admin.firestore();

    const ficha = snap.data();
    const medicoRef = db.doc(`users/${ficha.medico}`);

    return db.runTransaction(async transaction => {
      const docMedico = await transaction.get(medicoRef);
      const qtdFichas = (docMedico.data().qtdFichas || 0) + 1;

      transaction
        .update(medicoRef, { qtdFichas: qtdFichas })
        .update(snap.ref, { numero: qtdFichas });
    });
  });

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
