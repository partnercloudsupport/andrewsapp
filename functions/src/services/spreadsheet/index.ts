
// import * as ejs from "ejs";
// import { Stream } from "stream";
// import TemplatePDF from "../../enums/templates";
import * as admin from "firebase-admin";
// import * as QRCode from 'qrcode';
const {google} = require('googleapis');
const key = require('../key.json')
const SCOPES = ['https://www.googleapis.com/auth/spreadsheets'];
const jwt = new google.auth.JWT(key.client_email, null, key.private_key, SCOPES)
import {ServiceItem, CustomerAccount, Workorder} from '../../interfaces/';
import { DocumentSnapshot } from "firebase-functions/lib/providers/firestore";
export class Spreadsheet {

    constructor() {
       
    }
   private async _getCustomer(workorderId: string){
    const doc = await admin
    .firestore()
    .collection("workorders")
    .doc(workorderId)
    .get() as any
    var order = doc.data() as Workorder
    return order.customer;
   }
    async updateSpreadsheet(snap: DocumentSnapshot){
        let item = snap.data() as ServiceItem;
        item.id = snap.ref.id
        item.pictureURL = `=IMAGE("${snap.data().pictures[0].url}")`
        const customer = await this._getCustomer(item.workorderId)
        item.customerName = customer.lastName;
        item.customerPhone = customer.phones[0];
        console.log(item)
        this.appendRow(item)

    }
    async appendRow(item: ServiceItem){

console.log('starting appendRow ...')
       this._appendPromise({
            // spreadsheetId: '1UT109UQ9nqy6APxgcFpK3cRan_TV9e_loklteGvWu9s',
            spreadsheetId: '1jfF329Aj0DvsvsUcOnh2vaKPwKZFW1bDi9mxO1oNqDU',
            range: 'A:S',
            valueInputOption: 'USER_ENTERED',
            insertDataOption: 'INSERT_ROWS',
            resource: {
              values: [[
            
               item.customerName,    // string //O
               item.customerPhone,  
               item.status,
               item.priority,   // string //A
               item.prettyCreatedAt,
               item.prettyDueAt, 
               ' ',
               item.length,    // number //G
               item.width, 
               item.hasUrine,
               item.needsRepair,
               ' ',  
               item.intake_notes,
               item.pictureURL, 
               item.workorderId,    // string //P
               item.id, 
               'Not Yet Started', // string //E
            // string //P
            //    item.dueDateTime,    // string //C
            //    item.hasUrine,    // boolean //D
            //    item.isDone,    // boolean //F
            //       // number //H
            //    item.pictureURL,    // Array<Picture> //I
            //    item.price,    // number //J
            //    item.serviceName,    // string //K
            //    item.smGUID,    // string //L
            //    item.smWorkorderId,    // string //M
            //    item.tagColor,    // string //N
            //    item.tagId,    // string //O
                ]],
            },
    })
    }

    private _appendPromise(requestWithoutAuth) {
        return new Promise((resolve, reject) => {
        //   return getAuthorizedClient().then((client) => {
            console.log(requestWithoutAuth)
            const sheets = google.sheets('v4');
            const request = requestWithoutAuth;
             request.auth = jwt;
            return sheets.spreadsheets.values.append(request, (err, response) => {
              if (err) {
                console.log(`The API returned an error: ${err}`);
                return err;
              }
              console.log(response)

              return response;
            });
        //   });
        });

    }
}

function init() {
    return new Spreadsheet();
}

export default init;