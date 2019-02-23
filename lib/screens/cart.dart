import 'package:flutter/material.dart';
import 'package:tayar/widgets/scaffold.dart';

class CartPage extends StatefulWidget {
  @override
  _Cart createState() => _Cart();
}

class _Cart extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      cartIcon: false,
      title: "Cart",
      body: Center(
        child: Text('Coming soon..'),
      ),
    );
  }
}
