'use strict';

import * as Joi from 'joi';
import * as validate from "express-validation";
import { JoiState, JoiDocument } from '../../config/joiExtensions';
import { Scope } from '../../enums/scope';

export const userSchemas = {
    create: {
        email: Joi.string().required(),
        senha: Joi.string().required(),
        nome: Joi.string().required(),
        cpf: JoiDocument.document().cpf().required(),
        data_nascimento: Joi.string().required(),
        telefone: Joi.string().required(),
        scope: Joi.forbidden(),
        status: Joi.forbidden(),
    },
    update: {
        email: Joi.string().optional(),
        senha: Joi.forbidden(),
        nome: Joi.string().required(),
        cpf: JoiDocument.document().cpf().required(),
        data_nascimento: Joi.string().required(),
        telefone: Joi.string().required(),
        scope: Joi.forbidden(),
        status: Joi.forbidden(),
    },
    updateLogged: {
        email: Joi.string().optional(),
        senha: Joi.string().optional(),
        nome: Joi.string().required(),
        cpf: JoiDocument.document().cpf().required(),
        data_nascimento: Joi.string().required(),
        telefone: Joi.string().required(),
        scope: Joi.forbidden(),
        status: Joi.forbidden(),
    },
    changeStatus: {
        status: Joi.number().valid(0, 1).required(),
    },
    changeScope: {
        scope: Joi.string().valid(Scope.USER, Scope.ADMIN).required(),
    }
}

class UserValidator {

    create() {
        const model = {
            body: userSchemas.create
        }

        // retorna o middleware de validação
        return validate(model);
    }

    update() {
        const model = {
            body: userSchemas.update
        }

        // retorna o middleware de validação
        return validate(model);
    }

    updateLogged() {
        const model = {
            body: userSchemas.updateLogged
        }

        // retorna o middleware de validação
        return validate(model);
    }

    changeStatus() {
        const model = {
            body: userSchemas.changeStatus
        }

        // retorna o middleware de validação
        return validate(model);
    }

    changeScope() {
        const model = {
            body: userSchemas.changeScope
        }

        // retorna o middleware de validação
        return validate(model);
    }

}

function init() {
    return new UserValidator();
}

export default init;