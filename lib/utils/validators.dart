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

  passwordValidator(dynamic userInput) {
    if (!_matchPasswordRules(userInput)) {
      return _Return(
          result: false, message: "Password must be at least 8 characters");
    }
    return _Return(result: true, message: null);
  }

  bool _matchPasswordRules(dynamic userInput) {
    String pattern = r'^\w{8,128}$';
    return RegExp(
      pattern,
      multiLine: false,
    ).hasMatch(userInput);
  }

  bool _matchPhoneNumber(dynamic userInput) {
    return RegExp(
      r'^01(0|1|2|5)\d{8}$',
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
