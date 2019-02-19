'use strict';

import { Router } from "express";

// import sub-routers
import users from "./users";

import devices from "./devices";

const router = Router();

import { config } from "./../storage/firebase/config";

/**
 * Initialize firebase
 */
config.initializeApp();

// mount express paths, any addition middleware can be added as well.
// ex. router.use('/pathway', middleware_function, sub-router);

router.use('/users', users);

router.use('/devices', users);

// Export the router
export default router;