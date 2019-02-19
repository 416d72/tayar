import 'package:flutter/material.dart';
import 'package:tayar/common/sectionCard.dart';
import 'package:tayar/models/dummy.dart';
import 'package:tayar/models/sections.dart';

class MainPage extends StatefulWidget {
  @override
  _MainSections createState() => _MainSections();
}

class _MainSections extends State<MainPage> {
  var _refreshKey = GlobalKey<RefreshIndicatorState>();
  var cards = GridView(
    gridDelegate:
        SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 1.0),
  );
  List<Section> _sections = getSections();

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return cards;
  }

  @protected
  Future<void> _refresh() async {
    _refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      cards = GridView.count(
          crossAxisCount: 2,
          children: List.generate(_sections.length, (index) {
            return SectionCard(
              section: _sections[index],
            );
          }));
    });
    return null;
  }
}
