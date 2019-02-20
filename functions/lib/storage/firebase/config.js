"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const dotenv = require("dotenv");
dotenv.config();
const admin = require("firebase-admin");
class ConfigFirebase {
    initializeApp() {
        admin.initializeApp();
        // admin.initializeApp({
        //   credential: admin.credential.cert({
        //     clientEmail: process.env.CLIENT_EMAIL,
        //     privateKey: JSON.parse(`"${process.env.PRIVATE_KEY}"`),
        //     projectId: process.env.PROJECT_ID
        //   }),
        //   databaseURL: process.env.DATABASE_URL,
        //   storageBucket: process.env.STORAGE_BUCKET
        // });
        // admin.initializeApp();
        // console.log("Firebase initialized");
        // admin.initializeApp({
        //   credential: admin.credential.cert({
        //     clientEmail: process.env.CLIENT_EMAIL,
        //     privateKey: JSON.parse(`"${process.env.PRIVATE_KEY}"`),
        //     projectId: process.env.PROJECT_ID
        //   }),
        //   databaseURL: process.env.DATABASE_URL,
        //   storageBucket: process.env.STORAGE_BUCKET
        // });
        console.log("Functions initialized");
        //   initializeFunction(functions) {
        //       admin.initializeApp(functions.config().firebase);
    }
}
exports.config = new ConfigFirebase();
