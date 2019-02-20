import 'package:flutter/material.dart';
import 'package:tayar/common/sections/sectionsPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainSections createState() => _MainSections();
}

class _MainSections extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return SectionsPage(
      parent: '/',
    );
  }
}
