import 'package:fluro/fluro.dart';

class App {
  static Router router;
}

transitionDirection() {
  /*
  Determine what direction should transitions follow based on application's language
   */
  return TransitionType.inFromRight;
}
