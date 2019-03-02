import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tayar/app.dart';
import 'package:tayar/utils/validators.dart';
import 'package:tayar/widgets/scaffold.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<RegisterPage> {
  static Widget _mainButtonText = Text('Continue');
  static TextEditingController _phoneController = TextEditingController();
  static TextEditingController _smsController = TextEditingController();
  static TextEditingController _passwordController = TextEditingController();
  static StepState _firstStepState = StepState.editing;
  static StepState _secondStepState = StepState.indexed;
  static StepState _thirdStepState = StepState.indexed;
  static bool _isValidatingPhone = false;
  static bool _isValidatingSMSCode = false;
  static bool _isValidatingPassword = false;
  static String _errorMessage;
  static bool _passwordObscured = true;
  static int _currentStep = 0;
  static bool _phoneIsCorrect;
  static var _globalValidator = AuthValidator();

  // Auth
  FirebaseAuth _auth = FirebaseAuth.instance;
  static String _verificationID;
  static String _phoneNumber;
  static String _smsCode;
  static String _password;

//  void dispose() {
//    _inputController.dispose();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      cartIcon: false,
      searchIcon: false,
      title: 'Signup',
      body: Stepper(
        controlsBuilder: (BuildContext context,
            {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              RaisedButton(
                onPressed: onStepContinue,
                color: Theme.of(context).accentColor,
                child: _mainButtonText,
              ),
            ],
          );
        },
        currentStep: _currentStep,
        type: StepperType.vertical,
        steps: [
          Step(
            // Title of the Step
            title: Text("Phone Number"),
            subtitle: Text(
                'We need your 11 digit phone number to verify your identity!'),
            content: TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                labelText: '01XXXXXXXXX',
                errorText: _isValidatingPhone ? _errorMessage : null,
                border: OutlineInputBorder(
                  borderRadius: roundBorder(),
                ),
              ),
              style: Theme
                  .of(context)
                  .textTheme
                  .subtitle,
              maxLength: 11,
              keyboardType: TextInputType.number,
              autocorrect: false,
              onChanged: (String number) {
                if (!_globalValidator.matchDigit(number)) {
                  setState(() {
                    _isValidatingPhone = true;
                    _errorMessage = "Please enter correct phone number";
                  });
                } else {
                  setState(() {
                    _isValidatingPhone = false;
                    _errorMessage = "";
                  });
                }
              },
            ),
            state: _firstStepState,
            isActive: true,
          ),
          Step(
            title: Text('Verify'),
            subtitle: Text(
                'We have sent an SMS with verification code to your phone'),
            content: TextField(
              controller: _smsController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.message),
                labelText: 'Enter activation code',
                border: OutlineInputBorder(
                  borderRadius: roundBorder(),
                ),
                errorText: _isValidatingSMSCode ? _errorMessage : null,
              ),
              onChanged: (String userInput) {
                if (!_globalValidator.matchDigit(userInput)) {
                  setState(() {
                    _isValidatingSMSCode = true;
                    _errorMessage = "Please use only digits";
                  });
                } else {
                  setState(() {
                    _isValidatingSMSCode = false;
                    _errorMessage = null;
                  });
                }
              },
              textAlign: TextAlign.center,
              style: Theme
                  .of(context)
                  .textTheme
                  .subtitle,
              maxLength: 6,
              keyboardType: TextInputType.number,
              autocorrect: false,
            ),
            state: _secondStepState,
            isActive: true,
          ),
          Step(
            title: Text("Password"),
            subtitle: Text('Use only letters and digits'),
            content: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {
                    if (_passwordObscured) {
                      setState(() {
                        _passwordObscured = false;
                      });
                    } else {
                      setState(() {
                        _passwordObscured = true;
                      });
                    }
                  },
                ),
                labelText: 'Must be more than 8 characters and less than 128',
                border: OutlineInputBorder(
                  borderRadius: roundBorder(),
                ),
                errorText: _isValidatingPassword ? _errorMessage : null,
              ),
              obscureText: _passwordObscured,
              autocorrect: false,
              style: Theme
                  .of(context)
                  .textTheme
                  .subtitle,
            ),
            state: _thirdStepState,
            isActive: true,
          ),
        ],
        // Actions
        onStepTapped: (step) {
          setState(() {
            _currentStep = step;
          });
        },
        onStepContinue: () => _stepValidator(context),
      ),
    );
  }

  void _stepValidator(BuildContext context) {
    if (_currentStep == 0) {
      var validator =
      _globalValidator.phoneNumberValidator(_phoneController.text);
      if (!validator.result) {
        setState(() {
          _isValidatingPhone = true;
          _errorMessage = validator.message;
        });
      } else {
        _phoneConfirm(context);
      }
    } else if (_currentStep == 1) {
      var validator = _globalValidator.smsCodeValidator(_smsController.text);
      if (!validator.result) {
        setState(() {
          _isValidatingSMSCode = true;
          _errorMessage = validator.message;
        });
      } else {
        setState(() {
          _isValidatingSMSCode = false;
          _errorMessage = null;
          _secondStepState = StepState.complete;
          _thirdStepState = StepState.editing;
          _mainButtonText = Text('Confirm password');
        });
        _continue(2);
      }
    } else if (_currentStep == 2) {
      var validator =
      _globalValidator.passwordValidator(_passwordController.text);
      if (!validator.result) {
        setState(() {
          _isValidatingPassword = true;
          _errorMessage = validator.message;
        });
      } else {
        // Continue
      }
    }
  }

  Future _phoneConfirm(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Is this your phone?'),
            content:
            Text('Are you sure your number is ${_phoneController.text} ?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('No, return and edit'),
              ),
              FlatButton(
                onPressed: () =>
                    setState(() {
                      _phoneIsCorrect = true;
                      setState(() {
                        _isValidatingPhone = false;
                        _errorMessage = "";
                        _mainButtonText = Text('Verify');
                        _phoneNumber = "+2${_phoneController.text}";
                      });
                      Navigator.of(context).pop();
                      _firstStepState = StepState.complete;
                      _secondStepState = StepState.editing;
                      sendSMS();
                      _continue(1);
                    }),
                child: Text('Yes'),
              )
            ],
          );
        });
  }

  Future<void> sendSMS() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      _verificationID = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      _verificationID = verId;
    };
    final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user) {
      String token = user.getIdToken().toString();
      print("uid: ${user.uid}");
      print("meta: ${user.metadata}");
      print(token);
    };

    final PhoneVerificationFailed verifiedFailed = (AuthException exception) {
      print('Error: ${exception.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _phoneNumber,
      codeAutoRetrievalTimeout: autoRetrieve,
      codeSent: smsCodeSent,
      timeout: const Duration(seconds: 2),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifiedFailed,
    );
  }

  void _continue(int currentStep) {
    setState(() {
      if (_currentStep < 2) {
        _currentStep = _currentStep + 1;
      } else {
        // TODO: Validate data and register a new user
        return null;
      }
    });
  }
}
