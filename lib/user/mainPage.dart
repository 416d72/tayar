import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _MainSectionsWidget(),
    );
  }
}

class _MainSectionsWidget extends StatefulWidget {
  @override
  _MainSections createState() => _MainSections();
}

class _MainSections extends State<_MainSectionsWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(16, (index) {
        return Center(
          child: Text(
            "item $index",
            style: Theme
                .of(context)
                .textTheme
                .headline,
          ),
        );
      }),
    );
  }
}
