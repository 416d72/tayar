import 'package:flutter/material.dart';
import 'package:tayar/widgets/search.dart';
import 'package:tayar/widgets/sideDrawer.dart';

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
      appBar: topBar(context, true),
      drawer: SideDrawer(),
      body: widget.body,
    );
  }
}

class CustomScaffoldFull extends StatefulWidget {
  final Widget body;

  CustomScaffoldFull({@required this.body});

  @override
  _CustomScaffoldFullState createState() => _CustomScaffoldFullState();
}

class _CustomScaffoldFullState extends State<CustomScaffoldFull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(context, false),
      body: widget.body,
    );
  }
}

Widget topBar(context, bool drawer) {
  return AppBar(
    leading: Builder(builder: (context) {
      if (drawer == true) {
        return IconButton(
          icon: Icon(Icons.dehaze),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      } else {
        return IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      }
    }),
    title: SearchFieldWidget(),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        child: Icon(Icons.shopping_cart),
      )
    ],
  );
}
