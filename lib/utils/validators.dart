import 'package:flutter/material.dart';

class AuthValidator {
  bool matchDigit(dynamic userInput) {
    return RegExp(r'^(\d*)$', multiLine: false).hasMatch(userInput);
  }

  phoneNumberValidator(dynamic userInput) {
    if (userInput.length != 11) {
      return _Return(result: false, message: "Phone number must be 11 digits");
    } else if (!_matchPhoneNumber(userInput)) {
      return _Return(
          result: false, message: "Please enter correct mobile phone number");
    }
    return _Return(result: true, message: null);
  }

  passwordValidator(dynamic userInput, String phoneNumber) {
    if (!_matchPasswordRules(userInput)) {
      return _Return(
          result: false, message: "Password doesn't meet our security rules");
    } else if (userInput == phoneNumber) {
      return _Return(
          result: false,
          message: "You can't use your phone number as a password,");
    }
    return _Return(result: true, message: null);
  }

  smsCodeValidator(dynamic userInput) {
    if (!_matchSMSCode(userInput)) {
      return _Return(result: false, message: "Wrong Code");
    } else {
      return _Return(result: true, message: null);
    }
  }

  bool _matchPasswordRules(dynamic userInput) {
    return RegExp(
      r'^(\w){8,128}$',
      multiLine: false,
    ).hasMatch(userInput);
  }

  bool _matchPhoneNumber(dynamic userInput) {
    return RegExp(
      r'^01(0|1|2|5)\d{8}$',
      multiLine: false,
    ).hasMatch(userInput);
  }

  bool _matchSMSCode(dynamic userInput) {
    return RegExp(
      r'^\d{6}$',
      multiLine: false,
    ).hasMatch(userInput);
  }
}

class _Return {
  final bool result;
  final String message;

  const _Return({
    @required this.result,
    @required this.message,
  });
}
