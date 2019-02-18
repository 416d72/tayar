import 'package:flutter/material.dart';

class PreferencesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _PreferencesWidget();
  }
}

class _PreferencesWidget extends StatefulWidget {
  @override
  _Preferences createState() => _Preferences();
}

class _Preferences extends State<_PreferencesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Text("الإعدادات"),
    ));
  }
}
