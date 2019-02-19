import 'package:flutter/material.dart';

ThemeData customTheme() {
  TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      headline: base.headline.copyWith(
        fontFamily: 'Frutiger',
      ),
      title: base.title.copyWith(
        fontFamily: 'Frutiger',
      ),
      button: base.title.copyWith(
        fontFamily: 'Frutiger',
      ),
      subhead: base.title.copyWith(
        fontFamily: 'Frutiger',
        fontSize: 16.0,
      ),
    );
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryColor: Colors.deepOrange,
    accentColor: Colors.orangeAccent,
  );
}
