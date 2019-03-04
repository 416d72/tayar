import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tayar/app.dart';
import 'package:tayar/widgets/products.dart';
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
      title: widget.parent,
      body: Center(
        child: Text('Fancy'),
      ),
    );
  }

  Widget _defaultGrid() {
    Stream _stream;
    if (widget.collection == 'Sections') {
      _stream = Firestore.instance
          .collection('Sections')
          .where('active', isEqualTo: true)
          .where('parent', isEqualTo: widget.parent)
          .snapshots();
    } else {
      // Because I want to view products disabled if they are not active or have no offers
      _stream = Firestore.instance
          .collection('Products')
          .where('parent', isEqualTo: widget.parent)
          .snapshots();
    }
    return CustomScaffold(
      title: widget.parent,
      body: StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.count(
            crossAxisCount: 2,
            children: List.generate(snapshot.data.documents.length, (index) {
              var document = snapshot.data.documents[index];
              var id = document.reference.documentID;
              if (widget.collection == 'Sections') {
                return sectionCard(context, id, document['title'],
                    document['image'], document['child']);
              } else {
                // Products
                int offerCount = 0;
                double lowestPrice = 0;
                if (document['offers'] != null) {
                  offerCount = document['offers'].length;
                }
                if (offerCount > 0) {
                  lowestPrice = List<double>.from(document['offers']
                          .map((i) => i['price'].toDouble())
                          .toList())
                      .reduce(min);
                }
                return productCard(
                    context, id, document['title'], document['image'],
                    price: lowestPrice);
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
                placeholder: (BuildContext context, String url) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorWidget:
                    (BuildContext context, String url, Exception error) {
                  return Text("Error loading image");
                },
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
