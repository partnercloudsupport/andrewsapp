'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
const express_validation_1 = require("express-validation");
/**
 * catch joi ValidationError
 * @param error
 * @param req
 * @param res
 * @param next
 */
function joiHandler(error, req, res, next) {
    let outputError = {};
    // const isDev = isDevelopment(req);
    // bad request
    if (!(error instanceof express_validation_1.ValidationError)) {
        next(error);
        return;
    }
    outputError = {
        statusCode: error.status,
        error: error.statusText,
        message: error.message,
    };
    // if (isDev) {
    outputError = Object.assign({}, outputError, { errors: error.errors });
    // }
    res.status(error.status).json(outputError);
}
exports.joiHandler = joiHandler;
/**
 * catch boom error
 * @param error
 * @param req
 * @param res
 * @param next
 */
function boomHanlder(error, req, res, next) {
    let outputError = {};
    const isDev = isDevelopment(req);
    if (!error.isBoom) {
        next(error);
        return;
    }
    error.status = error.output.statusCode;
    outputError = error.output.payload;
    if (isDev) {
        console.error(error);
    }
    res.status(error.status).json(outputError);
}
exports.boomHanlder = boomHanlder;
/**
 * catch internal error
 * @param error
 * @param req
 * @param res
 * @param next
 */
function internalHandler(error, req, res, next) {
    let outputError = {};
    const isDev = isDevelopment(req);
    // internal error
    if (error.status >= 500 || !error.status) {
        outputError = {
            statusCode: 500,
            error: "Internal Server Error",
            message: "An unexpected error occurred",
        };
        console.error(error);
        if (isDev) {
            outputError = Object.assign({}, outputError, { message: error.message });
        }
    }
    else {
        next(error);
        return;
    }
    res.status(error.status || 500).json(outputError);
}
exports.internalHandler = internalHandler;
function isDevelopment(req) {
    const env = req.app.get('env');
    const isDev = env === 'development' || env === 'test';
    return isDev;
}
