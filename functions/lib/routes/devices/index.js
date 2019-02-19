'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const scope_1 = require("../../enums/scope");
const devices_validator_1 = require("./devices.validator");
const devices_controller_1 = require("./devices.controller");
const auth_1 = require("../auth");
const router = express_1.Router();
/**
 * restrict routers
 */
// this endpoint do not need a scope
router.post('/', devices_validator_1.default().create(), (req, res, next) => {
    devices_controller_1.default().create(req, res).catch(next);
});
router.put('/get/profile', auth_1.default(), (req, res, next) => {
    devices_controller_1.default().addUsertoDevice(req, res).catch(next);
});
router.put('/:id', devices_validator_1.default().update(), auth_1.default(scope_1.Scope.ADMIN), (req, res, next) => {
    devices_controller_1.default().setOwner(req, res).catch(next);
});
router.put('/', devices_validator_1.default().updateLogged(), auth_1.default(), (req, res, next) => {
    devices_controller_1.default().removeUser(req, res).catch(next);
});
router.post('/loc', devices_validator_1.default().changeStatus(), auth_1.default(scope_1.Scope.ADMIN), (req, res, next) => {
    devices_controller_1.default().addLocationUpdate(req, res).catch(next);
});
router.put('/scope/:id', devices_validator_1.default().changeScope(), auth_1.default(scope_1.Scope.ADMIN), (req, res, next) => {
    devices_controller_1.default().checkIn(req, res).catch(next);
});
router.put('/scope/:id', devices_validator_1.default().changeScope(), auth_1.default(scope_1.Scope.ADMIN), (req, res, next) => {
    devices_controller_1.default().checkOut(req, res).catch(next);
});
router.get('/get/profile', auth_1.default(), (req, res, next) => {
    devices_controller_1.default().addUsertoDevice(req, res).catch(next);
});
/**
 * public routers
 */
router.get('/hardware/:id', (req, res, next) => {
    devices_controller_1.default().isDeviceDeployable(req, res).catch(next);
});
exports.default = router;
