'use strict';
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const admin = require("firebase-admin");
const scope_1 = require("../../enums/scope");
const Boom = require("boom");
class DevicesController {
    create(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const user = req.body;
            try {
                // Seta o escopo do usuário como user
                user.scope = { admin: false, user: true };
                // Remove máscara do cpf
                user.cpf = user.cpf.replace(/\D/g, '');
                // Remove máscara do telefone
                user.telefone = user.telefone.replace(/\D/g, '');
                // Cria o usuário no firebase authentication
                const firebaseUser = yield admin.auth().createUser({
                    email: user.email,
                    password: user.senha,
                    disabled: false
                });
                // Pega o id do usuário criado no firebase authentication
                user.id = firebaseUser.uid;
                // Garantindo que só seja salvo no banco os dados que são necessários
                const data = {
                    id: user.id,
                    email: user.email,
                    nome: user.nome,
                    cpf: user.cpf,
                    data_nascimento: user.data_nascimento,
                    telefone: user.telefone,
                    scope: user.scope,
                    status: 1
                };
                // Cria o dado na storage
                yield admin.firestore().collection('users').doc(firebaseUser.uid).create(data);
                // Cria o escopo do usuário no firebase
                yield admin.auth().setCustomUserClaims(firebaseUser.uid, { scope: data.scope });
                res.json({ data });
            }
            catch (error) {
                if (error.code === "auth/email-already-exists") {
                    throw Boom.conflict('Usuário já existe');
                }
                if (error.code === "auth/invalid-password") {
                    throw Boom.badRequest(error.message);
                }
                if (user && user.id) {
                    yield admin.auth().deleteUser(user.id);
                }
                throw error;
            }
        });
    }
    addUsertoDevice(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const user = yield admin.firestore().collection('users').doc(req.credentials.uid).get();
            const data = user.data();
            // Remove o escopo da requisição
            delete data.scope;
            res.json(data);
        });
    }
    setOwner(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const user = yield admin.firestore().collection('users').doc(req.credentials.uid).get();
            const data = user.data();
            // Remove o escopo da requisição
            delete data.scope;
            res.json(data);
        });
    }
    removeUser(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const user = yield admin.firestore().collection('users').doc(req.credentials.uid).get();
            const data = user.data();
            // Remove o escopo da requisição
            delete data.scope;
            res.json(data);
        });
    }
    addLocationUpdate(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            // const user = await admin.firestore().collection('users').doc(req.credentials.uid).get();
            // const data = user.data();
            // Remove o escopo da requisição
            // delete data.scope;
            // res.json(data);
            res.json('hai2u');
        });
    }
    checkIn(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const uid = req.params.id;
            const body = req.body;
            yield admin.firestore().collection('users').doc(uid).get();
            const toUpdateFirebase = {
                disabled: body.status === 0 ? true : false
            };
            // Seta o status do usuário no firebase
            yield admin.auth().updateUser(uid, toUpdateFirebase);
            // Seta o status do usuário na storage
            yield admin.firestore().collection('users').doc(uid).update({ status: body.status });
            body.id = uid;
            res.json(body);
        });
    }
    checkOut(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const uid = req.params.id;
            let body = req.body;
            // User Scope
            switch (body.scope) {
                case scope_1.Scope.ADMIN:
                    body.scope = { admin: true, user: false };
                    break;
                case scope_1.Scope.USER:
                    body.scope = { admin: false, user: true };
                    break;
                default:
                    body.scope = { admin: false, user: false };
                    break;
            }
            yield admin.firestore().collection('users').doc(uid).get();
            // Seta o scope do usuário no firebase
            yield admin.auth().setCustomUserClaims(uid, { scope: body.scope });
            // Seta o scope do usuário na storage
            yield admin.firestore().collection('users').doc(uid).update({ scope: body.scope });
            body.id = uid;
            res.json(body);
        });
    }
    isDeviceDeployable(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const email = req.params.email;
            let isAvailable;
            try {
                // Verifica se o e-mail passado está disponível para cadastro
                yield admin.auth().getUserByEmail(email);
                isAvailable = false;
            }
            catch (error) {
                switch (error.code) {
                    case 'auth/user-not-found':
                        isAvailable = true;
                        break;
                    case 'auth/invalid-email':
                        throw Boom.badRequest(error.message);
                        break;
                    default:
                        throw error;
                        break;
                }
            }
            res.status(isAvailable ? 200 : 409).json({ email });
        });
    }
}
function init() {
    return new DevicesController();
}
exports.default = init;
