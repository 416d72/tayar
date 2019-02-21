import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Index extends StatefulWidget {
//  final String collection;
//
//  const Index({Key key, @required this.collection}) : super(key: key);

  @override
  _SectionsPageBuilder createState() => _SectionsPageBuilder();
}

class _SectionsPageBuilder extends State<Index> {
  String collection = 'Sections';

  @override
  void initState() {
    super.initState();
    this.collection = 'Sections';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection(this.collection)
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
              return cardWidget(
                  context, null, null, section['title'], section['image']);
            }),
          );
        },
      ),
    );
  }

  Widget cardWidget(BuildContext context, String collection, String parent,
      String title, String image) {
    return GestureDetector(
      onTap: () =>
          setState(() {
            this.collection = 'test';
          }),
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
                imageUrl: image,
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
                    title,
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
