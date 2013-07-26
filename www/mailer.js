cordova.define("cordova/plugin/Mailer", function (require, exports, module) {
    var exec = require("cordova/exec");

    var Mailer = function () {
    };

    Mailer.Result = {
        UNKNOWN: 0,
        CANCELLED: 1,
        SAVED: 2,
        SENT: 3,
        FAILED: 4
    };
    
    Mailer.prototype.compose = function (subject, body, attachment, success, fail) {
        fail = fail || function() { console.log('Mailer.compose failed'); };
        exec(success, fail, 'com.imsweb.Mailer', 'compose', [subject, body, attachment]);
    };

    var mailer = new Mailer();
    module.exports = mailer;
});
