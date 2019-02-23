import 'package:flutter/material.dart';
import 'package:tayar/widgets/scaffold.dart';

class VendorsPage extends StatefulWidget {
  @override
  _VendorsState createState() => _VendorsState();
}

class _VendorsState extends State<VendorsPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Vendors',
      body: Center(
        child: Text('Vendors List'),
      ),
    );
  }
}
