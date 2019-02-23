import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class App {
  static Router router;
}

// Theme
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

transitionDirection() {
  /*
  Determine what direction should transitions follow based on application's language
   */
  return TransitionType.inFromRight;
}
