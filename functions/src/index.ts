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
  const functions = require("firebase-functions");
  const admin = require("firebase-admin");
  admin.initializeApp();
  const { google } = require("googleapis");
  const jsonDiff = require("json-diff");
  const FireStoreParser = require("firestore-parser");
  const key = require("./newkey.json");
  const SCOPES = ["https://www.googleapis.com/auth/spreadsheets"];
  var auth;
  
  // exports.serviceItemCreate = functions.firestore
  //   .document("test/{workorderId}/serviceItems/{serviceItemId}")
  //   .onCreate((snap, context) => {
  //     console.log(snap);
  //     return Spreadsheet().updateSpreadsheet(snap);
  //     //  return item;
  //     //  return Spreadsheet().appendRow(item);
  //   });
  const WEBHOOK_URL =
    "https://script.google.com/d/11RcQ8a26oCqLSqmhm1qWQX0mWJUhHbk-h6aiMbfn2KaQsTiZmVtS5BDA/exec";
  
  exports.serviceItem_updated = functions.firestore
    .document("test/{workorderId}/serviceItems/{serviceItemId}")
    .onUpdate((change, context) => {
      console.log(change);
      const newValue = change.after.data();
      const previousValue = change.before.data();
      const diff = jsonDiff.diffString(previousValue, newValue);
      console.log(change);
      console.log(context);
    });
  //var data = require('./path/to/testData.json');
  //  var data = require('./data.json')
  // exports.serviceItem_created = functions.firestore
  // .document("test/{workorderId}/serviceItems/{serviceItemId}")
  exports.addMessage = functions.https.onRequest((req, res) => {
    var data = req.body;
  
    delete data["createdAt"];
    delete data["createdById"];
    delete data["notes"];
    delete data["pictures"];
    delete data["notes"];
    delete data["price"];
    delete data["serviceName"];
    delete data["smGUID"];
    delete data["pictures"];
    delete data["quantity"];
    delete data["dueDateTime"];
    delete data["prettyCreatedAt"];
    //alterations
    data["primaryPictureUrl"] = `=IMAGE(${data["primaryPictureUrl"]})`;
    //color row with status or tagcolor and use icon for the other
    var formatted = [];
    formatted.push(data["prettyDueAt"]);
    formatted.push(data["priority"]);
  
    formatted.push(data["tagColor"]);
    //customer stuff
    formatted.push(data["createdByName"]);
    formatted.push(data["intake_notes"]);
    formatted.push(data["needsRepair"]);
    formatted.push(data["hasUrine"]);
    formatted.push(data["length"]);
    formatted.push(data["width"]);
    formatted.push(data["primaryPictureUrl"]);
  
    //formatters and server data
    formatted.meta = [];
    formatted.meta.push(data["status"]);
    formatted.meta.push(data["isDone"]);
    formatted.meta.push(data["id"]);
    formatted.meta.push(data["smWorkorderId"]);
    formatted.meta.push(data["workorderId"]);
    formatted.meta.push(data["smServiceItemId"]);
    formatted.meta.push(data["tagId"]);
    var meta = [];
    meta.push(data["status"]);
    meta.push(data["isDone"]);
    meta.push(data["id"]);
    meta.push(data["smWorkorderId"]);
    meta.push(data["workorderId"]);
    meta.push(data["smServiceItemId"]);
    meta.push(data["tagId"]);
    formatted.meta = meta;
    console.log(data);
  });
  
  function appendData(data) {
    auth = new google.auth.JWT(key.client_email, null, key.private_key, SCOPES);
    var sheets = google.sheets("v4");
    sheets.spreadsheets.values.append(
      {
        auth: auth,
        spreadsheetId: "17X8QN_n4SvWcPbSTpsOGN1jNEHQMdqKOxJtVf4706ZI",
        range: "Sheet1!A2:G", //Change Sheet1 if your worksheet's name is something else
        valueInputOption: "USER_ENTERED",
        resource: {
          // values: [["Void", "Canvas", "Website"], ["Paul", "Shan", "Human"]]
          values: [data]
        }
      },
      (err, response) => {
        if (err) {
          console.log("The API returned an error: " + err);
          return;
        } else {
          console.log("Appended");
        }
      }
    );
  }
  
  // authentication.authenticate().then(auth => {
  //   appendData(auth);
  function update(i, newRow) {
    auth = new google.auth.JWT(key.client_email, null, key.private_key, SCOPES);
    var sheets = google.sheets("v4");
    sheets.spreadsheets.values.append(
      {
        auth: auth,
        spreadsheetId: "17X8QN_n4SvWcPbSTpsOGN1jNEHQMdqKOxJtVf4706ZI",
        range: `Sheet1!A${i}:G${i}`, //Change Sheet1 if your worksheet's name is something else
        valueInputOption: "USER_ENTERED",
        resource: {
          // values: [["Void", "Canvas", "Website"], ["Paul", "Shan", "Human"]]
          values: newRow
        }
      },
      (err, response) => {
        if (err) {
          console.log("The API returned an error: " + err);
          return;
        } else {
          console.log("Appended");
        }
      }
    );
  }
  function getDataAndUpdate(id, newRow) {
    auth = new google.auth.JWT(key.client_email, null, key.private_key, SCOPES);
  
    var sheets = google.sheets("v4");
    sheets.spreadsheets.values.get(
      {
        auth: auth,
        spreadsheetId: "17X8QN_n4SvWcPbSTpsOGN1jNEHQMdqKOxJtVf4706ZI",
        range: "Sheet1!A2:C" //Change Sheet1 if your worksheet's name is something else
      },
      (err, response) => {
        if (err) {
          console.log("The API returned an error: " + err);
          return;
        }
        var rows = response.data.values;
        if (rows.length === 0) {
          console.log("No data found.");
        } else {
          console.log(rows.length);
          for (var i = 0; rows.length; i++) {
            // console.log(rows[i]);
            var row = rows[i];
            var thisId = row[0];
            if (id === thisId) {
              update(i, newRow);
            }
            console.log(row.join(", "));
          }
        }
      }
    );
  }
  // getDataAndUpdate("123", [
  //   ["Void", "Canvas", "Website"],
  //   ["Paul", "Shan", "Human"]
  // ]);
  // authentication.authenticate().then(auth => {
  //   getData(auth);
  // });
  