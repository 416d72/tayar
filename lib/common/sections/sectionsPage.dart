import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SectionsPage extends StatefulWidget {
  final String collection;

  const SectionsPage({Key key, @required this.collection}) : super(key: key);

  @override
  _SectionsPageBuilder createState() => _SectionsPageBuilder();
}

class _SectionsPageBuilder extends State<SectionsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection(widget.collection)
            .where('active', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          return GridView.count(
            crossAxisCount: 2,
            children: List.generate(snapshot.data.documents.length, (index) {
              var section = snapshot.data.documents[index];
              return SectionCard(
                section: SectionBuilder(
                  collection: null,
                  parent: null,
                  title: section['title'],
                  imageURL: section['image'],
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

class SectionBuilder {
  final String collection;
  final String parent;
  final String title;
  final String imageURL;

  const SectionBuilder({
    this.collection,
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
      onTap: () => Scaffold.of(context).dispose(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Theme
                        .of(context)
                        .accentColor,
                    blurRadius: 1.0,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
              child: CachedNetworkImage(
                imageUrl: section.imageURL,
                placeholder: Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: Text("مشكلة في تحميل الصورة"),
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .subhead,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
