import 'package:flutter/material.dart';
import 'package:tayar/widgets/scaffold.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Login/Signup',
      body: Center(
        child: Text('Login here'),
      ),
    );
  }
}
