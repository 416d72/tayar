import 'package:flutter/material.dart';
import 'package:tayar/app.dart';
import 'package:tayar/widgets/search.dart';
import 'package:tayar/widgets/sideDrawer.dart';

class CustomScaffold extends StatefulWidget {
  final Widget body;
  final bool sideDrawer;
  final bool searchBar;
  final bool cartIcon;
  final String title;

  CustomScaffold({
    @required this.body,
    this.sideDrawer = false,
    this.title = '',
    this.searchBar = false,
    this.cartIcon = true,
  });
  @override
  State<StatefulWidget> createState() {
    return _CustomScaffoldState();
  }
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _topBar(context, widget.sideDrawer, widget.title,
          widget.searchBar, widget.cartIcon),
      drawer: SideDrawer(),
      body: widget.body,
    );
  }

  Widget _topBar(context, bool drawer, String title, bool searchBar,
      bool cartIcon) {
    return AppBar(
      leading: Builder(builder: (context) {
        if (drawer) {
          return IconButton(
            icon: Icon(Icons.dehaze),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        } else {
          return IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        }
      }),
      title: _topSearchBarDeterminer(searchBar, title),
      actions: <Widget>[
        _searchIcon(context, searchBar),
        _cartIcon(context, cartIcon),
      ],
    );
  }

  _topSearchBarDeterminer(bool searchBar, String title) {
    if (searchBar) {
      return SearchFieldWidget();
    } else {
      return Center(
        child: Text(title),
      );
    }
  }

  Widget _searchIcon(BuildContext context, bool searchIcon) {
    if (!searchIcon) {
      return IconButton(
        onPressed: () {
          App.router.navigateTo(context, '/');
        },
        icon: Icon(Icons.search),
      );
    }
    return Container();
  }

  Widget _cartIcon(BuildContext context, bool cartIcon) {
    if (cartIcon) {
      return IconButton(
        onPressed: () {
          App.router.navigateTo(context, '/cart');
        },
        icon: Icon(Icons.shopping_cart),
      );
    }
    return Container();
  }
}
