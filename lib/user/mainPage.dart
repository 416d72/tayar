import 'package:cached_network_image/cached_network_image.dart';
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
        return FlatButton(
          child: Stack(
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
