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
  static TextEditingController _authController = TextEditingController();
  static StepState _firstStepState = StepState.editing;
  static StepState _secondStepState = StepState.disabled;
  static StepState _thirdStepState = StepState.disabled;
  static bool _isValidating = false;
  static String _errorMessage;
  static int _currentStep = 0;
  static bool _phoneIsCorrect;
  static var _globalValidator = AuthValidator();

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
              FlatButton(
                onPressed: onStepCancel,
                child: const Text('Cancel'),
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
                icon: Icon(Icons.phone),
                labelText: '01XXXXXXXXX',
                errorText: _isValidating ? _errorMessage : null,
                border: OutlineInputBorder(
                  borderRadius: roundBorder(),
                ),
              ),
              style: Theme.of(context).textTheme.subhead,
              maxLength: 11,
              keyboardType: TextInputType.number,
              onChanged: (String number) {
                if (!_globalValidator.matchDigit(number)) {
                  setState(() {
                    _isValidating = true;
                    _errorMessage = "Please enter correct phone number";
                  });
                } else {
                  setState(() {
                    _isValidating = false;
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
                controller: _authController,
                decoration: InputDecoration(
                  labelText: 'Enter activation code',
                  errorText: _isValidating ? _errorMessage : null,
                ),
                maxLength: 6,
                keyboardType: TextInputType.number,
              ),
              state: _secondStepState,
              isActive: false),
          Step(
              title: Text("Password"),
              content: TextField(
                decoration: InputDecoration(
                  labelText: 'Type a strong password',
                ),
              ),
              state: _thirdStepState,
              isActive: false),
        ],
        // Actions
        onStepTapped: (step) {
          setState(() {
            _currentStep = step;
          });
        },
        onStepCancel: () {
          setState(() {
            if (_currentStep > 0) {
              _currentStep = _currentStep - 1;
            } else {
              App.router.pop(context);
            }
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
          _isValidating = true;
          _errorMessage = validator.message;
        });
      } else {
        _phoneConfirm(context);
      }
    }
  }

  Future _phoneConfirm(BuildContext context) {
    return showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Is this your phone?'),
          content:
              Text('Are you sure your number is ${_phoneController.text} ?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('No, return and edit'),
            ),
            FlatButton(
              onPressed: () => setState(() {
                    _phoneIsCorrect = true;
                    setState(() {
                      _isValidating = false;
                      _errorMessage = "";
                      _mainButtonText = Text('Verify');
                    });
                    Navigator.of(context).pop();
                    _firstStepState = StepState.complete;
                    _secondStepState = StepState.editing;
                    _continue(1);
                  }),
              child: Text('Yes'),
            )
          ],
        ));
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
