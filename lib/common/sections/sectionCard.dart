import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SectionBuilder {
  final String id;
  final String parent;
  final String title;
  final String imageURL;

  const SectionBuilder({
    this.id,
    this.parent,
    this.title,
    this.imageURL,
  });
}

class SectionCard extends StatelessWidget {
  final SectionBuilder section;

  SectionCard({@required this.section});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("Tapped!"),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).accentColor,
                    blurRadius: 1.0,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
              child: CachedNetworkImage(
                imageUrl: section.imageURL,
                placeholder: LinearProgressIndicator(),
                errorWidget: Text("Couldn't load image!"),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  alignment: AlignmentDirectional.bottomCenter,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text(
                    section.title,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
