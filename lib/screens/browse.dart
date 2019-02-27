import 'dart:async';
import 'dart:math';

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
      title: widget.parent.toString(),
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
              var document = snapshot.data.documents[index];
              var id = document.reference.documentID;
              if (widget.collection == 'Sections') {
                return sectionCard(context, id, document['title'],
                    document['image'], document['child']);
              } else {
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
    var _priceTag = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Not available",
          style:
              Theme.of(context).textTheme.display1.copyWith(color: Colors.red),
          softWrap: true,
        )
      ],
    );
    var _notAvailable = Container();
    if (price > 0) {
      _priceTag = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "$price EGP",
            style: Theme.of(context).textTheme.display1,
            softWrap: true,
          )
        ],
      );
    } else {
      // Price = 0 (AKA) Product not available
      _notAvailable = Container(
        decoration: BoxDecoration(
          color: Colors.white,
          backgroundBlendMode: BlendMode.color,
        ),
        child: Center(
          child: Opacity(
            opacity: 0.1,
            child: Text(""),
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        if (price == 0) {
          return null;
        } else {
          productDetails(context, documentID);
        }
      },
      onLongPress: () {
        // TODO: Add to favourite with animation
      },
      onDoubleTap: null,
      child: Container(
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
                      style: Theme.of(context).textTheme.subhead,
                      softWrap: true,
                    )
                  ],
                ),
                _priceTag,
              ],
            ),
            _notAvailable,
          ],
        ),
      ),
    );
  }

  Future<void> productDetails(context, documentID) async {
    var snapshot = await Firestore.instance
        .collection('Products')
        .document(documentID)
        .get();
    var product = snapshot.data;
    List offers = product.values.toList()[0];

    return showModalBottomSheet(
      context: context,
      builder: (builderContext) {
        var offersList = Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          defaultColumnWidth: IntrinsicColumnWidth(),
          children: [],
        );
        for (int i = 0; i < offers.length; i++) {
          offersList.children.add(TableRow(
            children: [
              TableCell(
                child: Container(
                  width: 32,
                  height: 32,
                  child: Image.asset('assets/images/sample-512.png'),
                ),
              ),
              TableCell(
                child: Text(offers[i]['id']),
              ),
              TableCell(
                child: Text(
                  "${offers[i]['price']} EGP",
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
              TableCell(
                child: IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      // TODO: Add to cart | Remove from cart
                    }),
              )
            ],
          ));
        }
        return ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 128,
                      height: 128,
                      child: CachedNetworkImage(imageUrl: product['image']),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          size: 42,
                        ),
                        onPressed: null),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        size: 36,
                      ),
                      onPressed: null,
                    ),
                  ],
                ),
              ],
            ),
            ListTile(
              title: Text(
                product['title'],
                style: Theme.of(context).textTheme.title,
              ),
            ),
            offersList,
          ],
        );
      },
    );
  }
}
