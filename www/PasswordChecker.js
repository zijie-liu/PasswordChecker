var exec = require("cordova/exec");

exports.checkPasswordStrength = function (arg0, success, error) {
  exec(success, error, "PasswordChecker", "checkPasswordStrength", [arg0]);
};
