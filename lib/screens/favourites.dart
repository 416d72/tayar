import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tayar/app.dart';
import 'package:tayar/database/models/favouritesModel.dart';
import 'package:tayar/database/sqlite.dart';
import 'package:tayar/widgets/scaffold.dart';

class FavouritesPage extends StatefulWidget {
  @override
  _Favourites createState() => _Favourites();
}

class _Favourites extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Favourite list',
      body: FutureBuilder<List<Favourite>>(
        future: fetchFavourites(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Sorry, there's a problem with database"),
            );
          } else if (snapshot.hasData) {
            return GridView.count(
              crossAxisCount: 2,
              children: List.generate(snapshot.data.length, (index) {
                var document = snapshot.data[index];
                return productCard(context, document.documentID, document.title,
                    document.image);
              }),
            );
          }
          return new Container(
            alignment: AlignmentDirectional.center,
            child: new CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget productCard(BuildContext context, String documentID, String title,
      String image) {
    return GestureDetector(
      onTap: () {
        print("Tapped");
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<Favourite>> fetchFavourites() async {
  var dbHelper = DBHelper();
  Future<List<Favourite>> favourites = dbHelper.getFavourites();
  return favourites;
}
