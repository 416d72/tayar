import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tayar/app.dart';

class ProductCard extends StatefulWidget {
  final String documentID;
  final String title;
  final String image;
  final double price;

  ProductCard({@required this.documentID,
    @required this.title,
    @required this.image,
    this.price});

  @override
  State<StatefulWidget> createState() {
    return _ProductCardState();
  }
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return productCard(context, widget.documentID, widget.title, widget.image,
        price: widget.price);
  }

  Widget productCard(BuildContext context, String documentID, String title,
      String image,
      {double price = 0}) {
    String _priceText = "";
    var _notAvailable = Container();
    if (price > 0) {
      _priceText = "$price EGP";
    } else if (price == 0) {
      _priceText = "Not Available";
    }
    return InkWell(
      onTap: () {
        App.router.navigateTo(context, "/product?id=$documentID");
      },
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
                      _priceText,
                      style: Theme
                          .of(context)
                          .textTheme
                          .display1
                          .copyWith(
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
}
