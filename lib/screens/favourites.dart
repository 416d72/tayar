import 'package:flutter/material.dart';
import 'package:tayar/database/models/favouritesModel.dart';
import 'package:tayar/database/sqlite.dart';
import 'package:tayar/widgets/products.dart';
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
                return ProductCard(
                  documentID: document.documentID,
                  title: document.title,
                  image: document.image,
                );
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
}

Future<List<Favourite>> fetchFavourites() async {
  var dbHelper = DBHelper();
  Future<List<Favourite>> favourites = dbHelper.getFavourites();
  return favourites;
}
