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
const Boom = require("boom");
class Auth {
    /**
     *
     * @param scopes if no scope is passed, it will not be validated
     */
    constructor(scopes) {
        this.scopes = scopes;
    }
    /**
     * Express middleware that validates Firebase ID Tokens passed in the Authorization HTTP header.
     * when decoded successfully, the ID Token content will be added as `req.credentials`.
     * @param req
     * @param res
     * @param next
     */
    authFirebase(req, res, next) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const { authorization } = req.headers;
                if (!authorization) {
                    next(Boom.unauthorized('Token not informed'));
                    return;
                }
                const bearer = authorization.split('Bearer ');
                const decodedToken = yield admin.auth().verifyIdToken((bearer[1] || bearer[0]).trim());
                if (this.scopes.length) {
                    this.checkScope(this.scopes, decodedToken.scope);
                }
                req.credentials = decodedToken;
                next();
            }
            catch (error) {
                next(error.isBoom ? error : Boom.forbidden('invalid token'));
            }
        });
    }
    ;
    /**
     * Express middleware for test
     * @param req
     * @param res
     * @param next
     */
    authTest(req, res, next) {
        req.credentials = {
            uid: process.env.TEST_USER_UID,
            email: process.env.TEST_USER_EMAIL,
            scope: {
                user: true,
                admin: true
            }
        };
        next();
    }
    /**
     * check if user has scope
     * @param scopes
     * @param userScope
     */
    checkScope(scopes, userScope) {
        if (!userScope) {
            throw Boom.badRequest('user do not have scope');
        }
        const hasScope = scopes.some((scope) => {
            return userScope[scope] === true;
        });
        if (!hasScope) {
            throw Boom.forbidden('insufficient privileges for this route');
        }
    }
    get config() {
        if (process.env.NODE_ENV === 'test') {
            return this.authTest.bind(this);
        }
        return this.authFirebase.bind(this);
    }
}
/**
 *
 * @param scopes if no scope is passed, it will not be validated
 */
function init(...scopes) {
    return new Auth(scopes).config;
}
exports.default = init;
