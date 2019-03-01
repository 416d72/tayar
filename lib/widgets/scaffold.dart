import 'package:flutter/material.dart';
import 'package:tayar/app.dart';
import 'package:tayar/widgets/search.dart';
import 'package:tayar/widgets/sideDrawer.dart';

class CustomScaffold extends StatefulWidget {
  final Widget body;
  final bool sideDrawer;
  final bool searchBar;
  final bool searchIcon;
  final bool cartIcon;
  final String title;

  CustomScaffold({
    @required this.body,
    this.sideDrawer = false,
    this.title = '',
    this.searchBar = false,
    this.searchIcon = true,
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

  Widget _topBar(
      context, bool drawer, String title, bool searchBar, bool cartIcon) {
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
        _searchIcon(context),
        _cartIcon(context, cartIcon),
        IconButton(
          // TODO: Remove this before final release
          icon: Icon(Icons.build),
          onPressed: () => App.router.navigateTo(context, '/login'),
        )
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

  Widget _searchIcon(BuildContext context) {
    if (widget.searchIcon) {
      if (!widget.searchBar) {
        return IconButton(
          onPressed: () {
            App.router.navigateTo(context, '/');
          },
          icon: Icon(Icons.search),
        );
      }
    } else {
      return Container();
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
