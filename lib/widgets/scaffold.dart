import 'package:flutter/material.dart';
import 'package:tayar/widgets/sideDrawer.dart';
import 'package:tayar/widgets/topBar.dart';

class CustomScaffold extends StatefulWidget {
  final Widget body;

  CustomScaffold({@required this.body});
  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(context),
      drawer: SideDrawer(),
      body: widget.body,
    );
  }
}
