import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tayar/app.dart';
import 'package:tayar/database/models/favouritesModel.dart';
import 'package:tayar/database/sqlite.dart';

class ProductPage extends StatefulWidget {
  final String productID;

  ProductPage({@required this.productID});

  @override
  State<StatefulWidget> createState() {
    return _ProductPageState();
  }
}

class _ProductPageState extends State<ProductPage> {
  DBHelper dbClient = DBHelper();
  IconData favIcon = Icons.favorite_border;

  @override
  Widget build(BuildContext context) {
    Future<DocumentSnapshot> document = Firestore.instance
        .collection('Products')
        .document(widget.productID)
        .get();
    dbClient.check(widget.productID).then((result) {
      if (result) {
        setState(() {
          favIcon = Icons.favorite;
        });
      }
    });
    return Scaffold(
      body: FutureBuilder(
        future: document,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // Display error message "Product doesn't exist"
            return null;
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List offers = List.from(snapshot.data['offers'].toList());
          return ListView(
            children: <Widget>[
              ListTile(
                leading: IconButton(
                    icon: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 28,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    onPressed: () {}),
                trailing: IconButton(
                    icon: Icon(
                      favIcon,
                      size: 36,
                    ),
                    onPressed: () {
                      dbClient
                          .toggleFavourite(Favourite(widget.productID,
                              snapshot.data['title'], snapshot.data['image']))
                          .then((addedToFavourite) {
                        addedToFavourite
                            ? setState(() {
                                favIcon = Icons.favorite;
                              })
                            : setState(() {
                                favIcon = Icons.favorite_border;
                              });
                      });
                    }),
              ),
              ListTile(
                title: CachedNetworkImage(
                  width: 128,
                  imageUrl: snapshot.data['image'],
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
              ListTile(
                title: Text(
                  snapshot.data['title'],
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/sample-512.png',
                        scale: 18,
                      ),
                      Text(offers[index]['id']),
                      Text(offers[index]['price'].toString()),
                      IconButton(
                        icon: Icon(Icons.add_shopping_cart),
                        onPressed: () {},
                      ),
                    ],
                  );
                  return Container(
                    decoration: cardShadow(context),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/sample-512.png',
                        scale: 18,
                      ),
                      title: Text(offers[index]['id']),
                      subtitle: Text(offers[index]['price'].toString()),
                      trailing: IconButton(
                        icon: Icon(Icons.add_shopping_cart),
                        onPressed: () {},
                      ),
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
    var offersList = Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      defaultColumnWidth: IntrinsicColumnWidth(),
      children: [],
    );
//    if (offers.length > 0) {
//      for (int i = 0; i < offers.length; i++) {
//        offersList.children.add(TableRow(
//          children: [
//            TableCell(
//              child: Container(
//                width: 32,
//                height: 32,
//                child: Image.asset('assets/images/sample-512.png'),
//              ),
//            ),
//            TableCell(
//              child: Text(offers[i]['id']),
//            ),
//            TableCell(
//              child: Text(
//                "${offers[i]['price']} EGP",
//                style: Theme.of(context).textTheme.subtitle,
//              ),
//            ),
//            TableCell(
//              child: IconButton(
//                  icon: Icon(Icons.add_shopping_cart),
//                  onPressed: () {
//                    // TODO: Add to cart | Remove from cart
//                  }),
//            )
//          ],
//        ));
//      }
//    }
//    return ListView(
//      children: <Widget>[
//        Stack(
//          children: <Widget>[
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Container(
//                  margin: EdgeInsets.all(10),
//                  width: 128,
//                  height: 128,
//                  child: CachedNetworkImage(imageUrl: product['image']),
//                ),
//              ],
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: <Widget>[
//                IconButton(
//                    icon: Icon(
//                      Icons.keyboard_arrow_down,
//                      size: 42,
//                    ),
//                    onPressed: null),
//              ],
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//                IconButton(
//                  icon: Icon(
//                    favIcon,
//                    size: 36,
//                  ),
//                  onPressed: () {
//                    dbClient
//                        .toggleFavourite(Favourite(
//                            documentID, product['title'], product['image']))
//                        .then((addedToFavourite) {
//                      addedToFavourite
//                          ? setState(() {
//                              favIcon = Icons.favorite;
//                            })
//                          : setState(() {
//                              favIcon = Icons.favorite_border;
//                            });
//                      print(addedToFavourite);
//                    });
//                  },
//                ),
//              ],
//            ),
//          ],
//        ),
//        ListTile(
//          title: Text(
//            product['title'],
//            style: Theme.of(context).textTheme.title,
//          ),
//        ),
//        offersList,
////          ListView(
////            children: <Widget>[
////              Text("Hello from inside list"),
////            ],
////          ),
//      ],
//    );
  }
}
