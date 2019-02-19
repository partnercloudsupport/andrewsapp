'use strict';

import { Router } from "express";
import { AuthRequest } from "../../interfaces";
import { Scope } from "../../enums/scope";
import DeviceValidator from "./devices.validator"
import DeviceController from "./devices.controller"
import Auth from "../auth"

const router = Router();

/**
 * restrict routers
 */

// this endpoint do not need a scope
router.post('/', DeviceValidator().create(),
    (req: AuthRequest, res, next) => {
        DeviceController().create(req, res).catch(next);
    });

router.put('/get/profile', Auth(),
    (req: AuthRequest, res, next) => {
        DeviceController().addUsertoDevice(req, res).catch(next);
    });

router.put('/:id', DeviceValidator().update(), Auth(Scope.ADMIN),
    (req: AuthRequest, res, next) => {
        DeviceController().setOwner(req, res).catch(next);
    });

router.put('/', DeviceValidator().updateLogged(), Auth(),
    (req: AuthRequest, res, next) => {
        DeviceController().removeUser(req, res).catch(next);
    });

router.post('/loc', DeviceValidator().changeStatus(), Auth(Scope.ADMIN),
    (req: AuthRequest, res, next) => {
        DeviceController().addLocationUpdate(req, res).catch(next);
    });

router.put('/scope/:id', DeviceValidator().changeScope(), Auth(Scope.ADMIN),
    (req: AuthRequest, res, next) => {
        DeviceController().checkIn(req, res).catch(next);
    });
    router.put('/scope/:id', DeviceValidator().changeScope(), Auth(Scope.ADMIN),
    (req: AuthRequest, res, next) => {
        DeviceController().checkOut(req, res).catch(next);
    });

    router.get('/get/profile', Auth(),
    (req: AuthRequest, res, next) => {
        DeviceController().addUsertoDevice(req, res).catch(next);
    });
/**
 * public routers
 */
router.get('/hardware/:id',
    (req, res, next) => {
        DeviceController().isDeviceDeployable(req, res).catch(next);
    });

export default router;