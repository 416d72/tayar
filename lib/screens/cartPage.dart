import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _CartWidget();
  }
}

class _CartWidget extends StatefulWidget {
  @override
  _Cart createState() => _Cart();
}

class _Cart extends State<_CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text("Coming soon ...")));
  }
}
