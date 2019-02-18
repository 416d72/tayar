import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 5.0),
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
        return FlatButton(
          padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
          child: Stack(
            alignment: AlignmentDirectional(0, 0),
            children: <Widget>[
              CachedNetworkImage(
                placeholder: CircularProgressIndicator(),
                imageUrl:
                "http://www.clker.com/cliparts/3/3/K/d/7/k/purple-square-light-hi.png",
              ),
              Center(
                child: Text("section"),
              )
            ],
          ),
          onPressed: () => null,
        );
      }),
    );
  }
}
