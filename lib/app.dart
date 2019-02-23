import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class App {
  static Router router;
}

transitionDirection() {
  /*
  Determine what direction should transitions follow based on application's language
   */
  return TransitionType.inFromRight;
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
        button: base.button.copyWith(
          fontFamily: 'Frutiger',
        ),
        subhead: base.subhead.copyWith(
          fontFamily: 'Frutiger',
          fontSize: 13,
        ),
        display1: base.display1.copyWith(
          fontFamily: 'Frutiger',
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ));
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryColor: Colors.deepOrange,
    accentColor: Colors.orangeAccent,
  );
}

cardShadow(context) {
  return BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.orangeAccent,
        blurRadius: 1.0,
        spreadRadius: 0.0,
      ),
    ],
  );
}
