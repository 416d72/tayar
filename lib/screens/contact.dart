import 'package:flutter/material.dart';
import 'package:tayar/widgets/scaffold.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Text('Contact Page'),
      ),
    );
  }
}
