import 'package:flutter/material.dart';

class SearchFieldWidget extends StatefulWidget {
  @override
  _SearchField createState() => _SearchField();
}

class _SearchField extends State<SearchFieldWidget> {
  // Display search input field
  @override
  Widget build(BuildContext context) {
    return Container(
//      alignment: Alignment(0.0, -1.0),
      child: TextFormField(
        style: Theme.of(context).textTheme.subhead,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0.0),
          labelText: "What are you looking for?",
        ),
      ),
    );
  }
}
