import 'package:flutter/material.dart';
import 'package:tayar/widgets/scaffold.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}
