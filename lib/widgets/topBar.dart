import 'package:flutter/material.dart';
import 'package:tayar/widgets/search.dart';

Widget topBar(context) {
  return AppBar(
    leading: Builder(
        builder: (context) => IconButton(
              icon: Icon(Icons.dehaze),
              onPressed: () => Scaffold.of(context).openDrawer(),
            )),
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
