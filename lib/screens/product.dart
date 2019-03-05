import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    double deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    double deviceHeight = MediaQuery
        .of(context)
        .size
        .height;

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
          offers.sort((vendor1, vendor2) {
            var result = vendor1["price"].compareTo(vendor2["price"]);
            if (result != 0) return result;
            return vendor1["price"].compareTo(vendor2["price"]);
          });
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
                  width: deviceWidth * 0.25,
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
                  "${snapshot.data['title']} (unit)",
                  style: Theme
                      .of(context)
                      .textTheme
                      .title,
                ),
              ),
              ListTile(
                title: Text(
                  "Available offers",
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: deviceHeight * 0.20,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      elevation: 3,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        overflow: Overflow.visible,
                        fit: StackFit.expand,
                        children: <Widget>[
                          Container(
                            // Background image
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: CachedNetworkImageProvider(
                                    "https://www.washingtonpost.com/resizer/WWLs91LUlbMpRXQMbDcLPXlFUhg=/1484x0/arc-anglerfish-washpost-prod-washpost.s3.amazonaws.com/public/AA43TKRJCY7PJGI3Y6PWFEF44I.jpg"),
                              ),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: CachedNetworkImage(
                              width: deviceWidth * 0.15,
                              imageUrl:
                              "https://www.siggraph.org/sites/default/files/org.flat.logo.400_0.jpg",
                              placeholder: (BuildContext context, String url) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              errorWidget: (BuildContext context, String url,
                                  Exception error) {
                                return Text("Error loading image");
                              },
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.3,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: Text(
                                  "${offers[index]['price'].toString()} EGP",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .display1,
                                ),
                              ),
                            ),
                          ),
                        ],
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
  }
}
