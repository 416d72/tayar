import 'package:flutter/material.dart';

class SearchFieldWidget extends StatefulWidget {
  @override
  _SearchField createState() => _SearchField();
}

class _SearchField extends State<SearchFieldWidget> {
  // Display search input field
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.subtitle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            height: 2,
          ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        labelText: "What are you looking for?",
      ),
    );
  }
}
