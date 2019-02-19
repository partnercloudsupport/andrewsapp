'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
const Joi = require("joi");
const validate = require("express-validation");
const joiExtensions_1 = require("../../config/joiExtensions");
const scope_1 = require("../../enums/scope");
exports.deviceSchemas = {
    create: {
        email: Joi.string().required(),
        senha: Joi.string().required(),
        nome: Joi.string().required(),
        cpf: joiExtensions_1.JoiDocument.document().cpf().required(),
        data_nascimento: Joi.string().required(),
        telefone: Joi.string().required(),
        scope: Joi.forbidden(),
        status: Joi.forbidden(),
    },
    update: {
        email: Joi.string().optional(),
        senha: Joi.forbidden(),
        nome: Joi.string().required(),
        cpf: joiExtensions_1.JoiDocument.document().cpf().required(),
        data_nascimento: Joi.string().required(),
        telefone: Joi.string().required(),
        scope: Joi.forbidden(),
        status: Joi.forbidden(),
    },
    updateLogged: {
        email: Joi.string().optional(),
        senha: Joi.string().optional(),
        nome: Joi.string().required(),
        cpf: joiExtensions_1.JoiDocument.document().cpf().required(),
        data_nascimento: Joi.string().required(),
        telefone: Joi.string().required(),
        scope: Joi.forbidden(),
        status: Joi.forbidden(),
    },
    changeStatus: {
        status: Joi.number().valid(0, 1).required(),
    },
    changeScope: {
        scope: Joi.string().valid(scope_1.Scope.USER, scope_1.Scope.ADMIN).required(),
    }
};
class DeviceValidator {
    create() {
        const model = {
            body: exports.deviceSchemas.create
        };
        // retorna o middleware de validação
        return validate(model);
    }
    update() {
        const model = {
            body: exports.deviceSchemas.update
        };
        // retorna o middleware de validação
        return validate(model);
    }
    updateLogged() {
        const model = {
            body: exports.deviceSchemas.updateLogged
        };
        // retorna o middleware de validação
        return validate(model);
    }
    changeStatus() {
        const model = {
            body: exports.deviceSchemas.changeStatus
        };
        // retorna o middleware de validação
        return validate(model);
    }
    changeScope() {
        const model = {
            body: exports.deviceSchemas.changeScope
        };
        // retorna o middleware de validação
        return validate(model);
    }
}
function init() {
    return new DeviceValidator();
}
exports.default = init;
