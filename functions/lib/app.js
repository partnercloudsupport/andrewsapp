'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
const dotenv = require("dotenv");
dotenv.config();
const boom_1 = require("boom");
const express = require("express");
const cookieParser = require("cookie-parser");
const logger = require("morgan");
const cors = require("cors");
const helmet = require("helmet");
const errorHandler_1 = require("./config/errorHandler");
const routes_1 = require("./routes");
class App {
    constructor() {
        // Run configuration methods on the Express instance.
        this.express = express();
        this.middleware();
        this.routes();
        // Handler must be after routers
        this.handler();
    }
    get config() {
        return this.express;
    }
    // Configure Express middleware.
    middleware() {
        this.express.use(logger('dev'));
        this.express.use(express.json());
        this.express.use(express.urlencoded({ extended: false }));
        this.express.use(cookieParser());
        this.express.use(cors());
        this.express.use(helmet());
    }
    // Configure API endpoints.
    routes() {
        this.express.use('/', routes_1.default);
    }
    // Configure error handler
    handler() {
        this.express.use(this.notFound);
        this.express.use(errorHandler_1.joiHandler);
        this.express.use(errorHandler_1.boomHanlder);
        this.express.use(errorHandler_1.internalHandler);
    }
    // catch 404 and forward to error handler
    notFound(req, res, next) {
        next(boom_1.notFound());
    }
    notFoundx(req, res, next) {
        next(boom_1.notFound());
    }
}
exports.default = new App().config;
