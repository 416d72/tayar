import 'package:flutter/material.dart';
import 'package:tayar/widgets/scaffold.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Text('About Page'),
      ),
    );
  }
}
