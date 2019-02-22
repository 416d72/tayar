import 'package:flutter/material.dart';
import 'package:tayar/widgets/sideDrawer.dart';
import 'package:tayar/widgets/topBar.dart';

class CustomScaffold extends Scaffold {
  @override
  Widget get drawer => SideDrawer();

  @override
  PreferredSizeWidget get appBar => topBar();
}
