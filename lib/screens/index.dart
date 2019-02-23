import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tayar/app.dart';
import 'package:tayar/widgets/scaffold.dart';

class Index extends StatefulWidget {
  /* This is the main page which contains top deals, best selling products...etc
  *
  * */
//  final String collection;
//
//  const Index({Key key, @required this.collection}) : super(key: key);
  @override
  _SectionsPageBuilder createState() => _SectionsPageBuilder();
}

class _SectionsPageBuilder extends State<Index> {
  Stream _stream = Firestore.instance
      .collection('Sections')
      .where('active', isEqualTo: true)
      .where('parent', isEqualTo: '/')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      sideDrawer: true,
      searchBar: true,
      body: StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          return GridView.count(
            crossAxisCount: 2,
            children: List.generate(snapshot.data.documents.length, (index) {
              var section = snapshot.data.documents[index];
              return sectionCard(context, section.reference.documentID,
                  section['title'], section['image'], section['child']);
            }),
          );
        },
      ),
    );
  }

  Widget sectionCard(BuildContext context, String parent, String title,
      String image, String child) {
    return GestureDetector(
      onTap: () {
        App.router.navigateTo(
          context,
          '/browse?collection=$child&parent=$parent',
        );
      },
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
                imageUrl: image,
                placeholder: Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: Text("Error loading image"),
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
                    style: Theme.of(context).textTheme.subhead,
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
