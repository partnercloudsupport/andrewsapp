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
const pdf = require("html-pdf");
const ejs = require("ejs");
const admin = require("firebase-admin");
const QRCode = require("qrcode");
// imagens do cabeçalho e rodapé devem estar em base64
const assets = require("./templates/components/assets.json");
class RenderPdf {
    constructor() {
        this.path = `${__dirname}/templates/`;
    }
    /**
     * Return a URL to PDF or create it and return a URL
     * @param data
     * @param filePath caminho no Storage (Firebase)
     * @param template
     */
    getURL(data, filePath, template) {
        return __awaiter(this, void 0, void 0, function* () {
            //get the bucket
            const bucket = admin.storage().bucket();
            const file = bucket.file(`${filePath}.pdf`);
            return this.createFile(file, data, template);
            //check if file exists
            const exists = yield file.exists();
            let url;
            if (exists[0]) {
                // if exists: return the url
                url = yield this.createUrl(file);
            }
            else {
                // if not exists: create the file and url
                url = yield this.createFile(file, data, template);
            }
            return url;
        });
    }
    /**
     * Create the PDF and return the URL
     * @param file
     * @param data
     */
    createFile(file, data, template) {
        return new Promise((resolve, reject) => __awaiter(this, void 0, void 0, function* () {
            try {
                const stream = yield this.toStream(template, data);
                stream.pipe(file.createWriteStream())
                    .on('error', err => reject(err))
                    .on('finish', () => {
                    resolve(this.createUrl(file));
                });
            }
            catch (error) {
                reject(error);
            }
        }));
    }
    /**
     * Create a URL to access the PDF
     * @param file
     */
    createUrl(file) {
        return __awaiter(this, void 0, void 0, function* () {
            // date for the token
            const date = new Date();
            date.setDate(date.getDate() + 1);
            const url = yield file.getSignedUrl({ action: 'read', expires: date.toDateString() });
            return url;
        });
    }
    /**
     * Render a template and return the stream
     * @param template
     * @param data
     */
    toStream(template, data) {
        return new Promise((resolve, reject) => __awaiter(this, void 0, void 0, function* () {
            // create a qrcode
            assets.qrcode = yield QRCode.toDataURL(data.id)
                .catch(err => reject(err));
            ejs.renderFile(this.path + template, { data, assets }, (errEjs, html) => {
                if (errEjs) {
                    reject(errEjs);
                }
                const options = {
                    width: "612px",
                    height: "858px",
                    footer: {
                        "height": "55mm",
                    }
                };
                pdf.create(html, options).toStream((errPdf, stream) => {
                    if (errPdf) {
                        reject(errPdf);
                    }
                    resolve(stream);
                });
            });
        }));
    }
}
exports.RenderPdf = RenderPdf;
function init() {
    return new RenderPdf();
}
exports.default = init;
