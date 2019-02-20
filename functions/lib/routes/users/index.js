'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const scope_1 = require("../../enums/scope");
const users_validator_1 = require("./users.validator");
const users_controller_1 = require("./users.controller");
const auth_1 = require("../auth");
const router = express_1.Router();
/**
 * restrict routers
 */
// this endpoint do not need a scope
router.post('/', users_validator_1.default().create(), (req, res, next) => {
    users_controller_1.default().create(req, res).catch(next);
});
router.get('/get/profile', auth_1.default(), (req, res, next) => {
    users_controller_1.default().profile(req, res).catch(next);
});
router.put('/:id', users_validator_1.default().update(), auth_1.default(scope_1.Scope.ADMIN), (req, res, next) => {
    users_controller_1.default().update(req, res).catch(next);
});
router.put('/', users_validator_1.default().updateLogged(), auth_1.default(), (req, res, next) => {
    users_controller_1.default().updateLogged(req, res).catch(next);
});
router.put('/status/:id', users_validator_1.default().changeStatus(), auth_1.default(scope_1.Scope.ADMIN), (req, res, next) => {
    users_controller_1.default().changeStatus(req, res).catch(next);
});
router.put('/scope/:id', users_validator_1.default().changeScope(), auth_1.default(scope_1.Scope.ADMIN), (req, res, next) => {
    users_controller_1.default().changeScope(req, res).catch(next);
});
/**
 * public routers
 */
router.get('/email/:email', (req, res, next) => {
    users_controller_1.default().isEmailAvailable(req, res).catch(next);
});
router.get('/hif', (req, res, next) => {
    users_controller_1.default().hi(req, res).catch(next);
});
router.post('/customAuth', (req, res, next) => {
    users_controller_1.default().customAuth(req, res).catch(next);
    // res.json({ "Asdf":"asdfdfd" });
});
exports.default = router;
