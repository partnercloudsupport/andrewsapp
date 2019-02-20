"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
// import sub-routers
const users_1 = require("./users");
const router = express_1.Router();
const config_1 = require("./../storage/firebase/config");
/**
 * Initialize firebase
 */
config_1.config.initializeApp();
// mount express paths, any addition middleware can be added as well.
// ex. router.use('/pathway', middleware_function, sub-router);
router.use("/users", users_1.default);
router.use("/devices", users_1.default);
// Export the router
exports.default = router;
