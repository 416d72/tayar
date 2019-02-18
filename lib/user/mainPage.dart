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
            child: FlatButton(
                onPressed: null,
                child: Column(
                  children: <Widget>[
                    Text(
                      "قسم $index",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline,
                    ),
                  ],
                )));
      }),
    );
  }
}
