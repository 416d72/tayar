import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tayar/app.dart';

Widget productCard(
    BuildContext context, String documentID, String title, String image,
    {double price = 0}) {
  String _priceText = "";
  var _notAvailable = Container();
  if (price > 0) {
    _priceText = "$price EGP";
  } else if (price == 0) {
    _priceText = "Not Available";
//    _notAvailable = Container(
//      decoration: BoxDecoration(
//        color: Colors.white,
//        backgroundBlendMode: BlendMode.color,
//      ),
//      child: Center(
//        child: Opacity(
//          opacity: 0.1,
//          child: Text(""),
//        ),
//      ),
//    );
  }
  return GestureDetector(
    onTap: () {
      productDetails(context, documentID);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _priceText,
                    style: Theme.of(context).textTheme.display1.copyWith(
                          color: price == 0 ? Colors.red : Colors.black,
                        ),
                    softWrap: true,
                  )
                ],
              ),
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
      if (offers.length > 0) {
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
                    onPressed: () {},
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
//          ListView(
//            children: <Widget>[
//              Text("Hello from inside list"),
//            ],
//          ),
        ],
      );
    },
  );
}
