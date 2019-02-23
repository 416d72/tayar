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
    this.sideDrawer = true,
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
      actions: _actions(context, searchBar, cartIcon),
    );
  }

  _topSearchBarDeterminer(bool searchBar, String title) {
    if (searchBar) {
      return SearchFieldWidget();
    } else {
      return title;
    }
  }

  List<Widget> _actions(BuildContext context, bool searchIcon, bool cartIcon) {
    List<Widget> actions;
    if (!searchIcon) {
      actions.add(
        IconButton(
          onPressed: () {
            App.router.navigateTo(context, '/search');
          },
          icon: Icon(Icons.search),
        ),
      );
    }
    if (cartIcon) {
      actions.add(IconButton(
        onPressed: () {
          App.router.navigateTo(context, '/cart');
        },
        icon: Icon(Icons.shopping_cart),
      ));
    }
    return actions;
  }
}
