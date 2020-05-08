var exec = require("cordova/exec");

exports.checkPasswordStrength = function (success, error, arg) {
  exec(success, error, "PasswordChecker", "checkPasswordStrength", [arg]);
};
