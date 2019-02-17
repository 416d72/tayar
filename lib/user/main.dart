import 'package:flutter/material.dart';

class MainList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _SearchFieldWidget(),
    );
  }
}

class _SearchFieldWidget extends StatefulWidget {
  @override
  _SearchField createState() => _SearchField();
}

class _SearchField extends State<_SearchFieldWidget> {
  // Display search input field
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0.0, -1.0),
      height: 50.0,
      margin: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0.0),
          icon: Icon(Icons.search),
          labelText: "بتدور على ايه ..",
        ),
      ),
    );
  }
}
