import 'package:flutter/material.dart';
import 'package:tayar/app.dart';
import 'package:tayar/utils/validators.dart';
import 'package:tayar/widgets/scaffold.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  static var _globalValidator = AuthValidator();
  static bool _isValidatingPhone = false;
  static bool _isValidatingPassword = false;
  static String _errorMessage;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      cartIcon: false,
      searchIcon: false,
      title: 'Login',
      body: ListView(
        children: <Widget>[
          SafeArea(
            minimum: EdgeInsets.all(25),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      ListTile(
                        title: TextField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: roundBorder(),
                            ),
                            labelText: 'Phone number',
                            errorText:
                            _isValidatingPhone ? _errorMessage : null,
                          ),
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle,
                          maxLength: 11,
                          keyboardType: TextInputType.number,
                          onChanged: (String userInput) {
                            if (!_globalValidator.matchDigit(userInput)) {
                              setState(() {
                                _isValidatingPhone = true;
                                _errorMessage =
                                "Please enter correct phone number";
                              });
                            } else {
                              setState(() {
                                _isValidatingPhone = false;
                                _errorMessage = "";
                              });
                            }
                          },
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: roundBorder(),
                            ),
                            labelText: 'Password',
                            errorText:
                            _isValidatingPassword ? _errorMessage : null,
                          ),
                          obscureText: true,
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
            child: ListTile(
              title: RaisedButton(
                onPressed: () {
                  _inputValidator();
                },
                child: Text(
                  'Login',
                  style: Theme
                      .of(context)
                      .textTheme
                      .title,
                ),
                color: Theme
                    .of(context)
                    .accentColor,
                highlightColor: Theme
                    .of(context)
                    .accentColor,
                shape: RoundedRectangleBorder(borderRadius: roundBorder()),
              ),
            ),
          ),
          ListTile(
            leading: FlatButton(
              onPressed: () {
                App.router.navigateTo(context, '/register');
              },
              child: Text(
                'New Account',
                style: Theme
                    .of(context)
                    .textTheme
                    .button,
              ),
            ),
            trailing: FlatButton(
              onPressed: () {},
              child: Text(
                'Forgot password?',
                style: Theme
                    .of(context)
                    .textTheme
                    .button,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _inputValidator() {
    if (_phoneValidator() && _passwordValidator()) {
      //TODO: connect with auth service
      return null;
    }
  }

  bool _passwordValidator() {
    var validator =
    _globalValidator.passwordValidator(_passwordController.text, null);
    if (!validator.result) {
      _isValidatingPassword = true;
      _errorMessage = validator.message;
      return false;
    } else {
      setState(() {
        _isValidatingPassword = false;
        _errorMessage = null;
      });
      return true;
    }
  }

  bool _phoneValidator() {
    var validator =
    _globalValidator.phoneNumberValidator(_phoneController.text);
    if (!validator.result) {
      setState(() {
        _isValidatingPhone = true;
        _errorMessage = validator.message;
      });
      return false;
    } else {
      setState(() {
        _isValidatingPhone = false;
        _errorMessage = null;
      });
      return true;
    }
  }
}
