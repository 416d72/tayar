import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tayar/app.dart';
import 'package:tayar/widgets/scaffold.dart';

class BrowsePage extends StatefulWidget {
  final String collection;
  final String parent;
  final bool fancy;

  const BrowsePage(
      {Key key, @required this.collection, @required this.parent, this.fancy})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BrowsePageState();
  }
}

class _BrowsePageState extends State<BrowsePage> {
  @override
  Widget build(BuildContext context) {
    if (widget.fancy) {
      return _fancyView();
    } else {
      return _defaultGrid();
    }
  }

  Widget _fancyView() {
    return CustomScaffold(
      title: widget.parent.toString(),
      body: Center(
        child: Text('Fancy'),
      ),
    );
  }

  Widget _defaultGrid() {
    return CustomScaffold(
      title: widget.parent.toString(),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection(widget.collection)
            .where('active', isEqualTo: true)
            .where('parent', isEqualTo: widget.parent)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          return GridView.count(
            crossAxisCount: 2,
            children: List.generate(snapshot.data.documents.length, (index) {
              var document = snapshot.data.documents[index];
              var id = document.reference.documentID;
              if (widget.collection == 'Sections') {
                return sectionCard(context, id, document['title'],
                    document['image'], document['child']);
              } else {
                double lowestPrice = 1.99;
                return productCard(context, id, document['title'],
                    document['image'], lowestPrice);
              }
            }),
          );
        },
      ),
    );
  }

  Widget sectionCard(BuildContext context, String documentID, String title,
      String image, String child) {
    return GestureDetector(
      onTap: () {
        return App.router.navigateTo(
            context, '/browse?collection=$child&parent=$documentID');
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: cardShadow(context),
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

  Widget productCard(BuildContext context, String documentID, String title,
      String image, double price) {
    return Container(
      decoration: cardShadow(context),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 70),
            child: Center(
              child: CachedNetworkImage(
                imageUrl: image,
                placeholder: Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: Text("Error loading image"),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: Theme
                        .of(context)
                        .textTheme
                        .subhead,
                    softWrap: true,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "$price EGP",
                    style: Theme
                        .of(context)
                        .textTheme
                        .display1,
                    softWrap: true,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
