import 'package:flutter/material.dart';
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
      body: Center(
        child: Text('Favourite items list '),
      ),
    );
  }
}
