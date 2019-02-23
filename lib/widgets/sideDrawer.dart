import 'package:flutter/material.dart';
import 'package:tayar/app.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                Icon(Icons.account_circle),
                SizedBox(height: 10.0),
                Text('Guest'),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text(
                    "Home",
                    style: Theme
                        .of(context)
                        .textTheme
                        .button,
                  ),
                  onTap: () {
                    App.router.pop(context);
                    App.router.navigateTo(context, '/',
                        transition: transitionDirection());
                  },
                ),
                Divider(
                  height: 0.0,
                ),
                ListTile(
                  leading: Icon(Icons.explore),
                  title: Text(
                    "Products",
                    style: Theme
                        .of(context)
                        .textTheme
                        .button,
                  ),
                  onTap: () {
                    App.router.pop(context);
                    App.router.navigateTo(context, '/',
                        transition: transitionDirection());
                  },
                ),
                Divider(
                  height: 0.0,
                ),
                ListTile(
                  leading: Icon(Icons.store),
                  title: Text(
                    "Vendors",
                    style: Theme
                        .of(context)
                        .textTheme
                        .button,
                  ),
                  onTap: () {
                    App.router.pop(context);
                    App.router.navigateTo(context, '/',
                        transition: transitionDirection());
                  },
                ),
                Divider(
                  height: 0.0,
                ),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text(
                    "Favourites",
                    style: Theme.of(context).textTheme.button,
                  ),
                  onTap: () {
                    App.router.pop(context);
                    App.router.navigateTo(context, '/',
                        transition: transitionDirection());
                  },
                ),
                Divider(
                  height: 0.0,
                ),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text(
                    "History",
                    style: Theme.of(context).textTheme.button,
                  ),
                  onTap: () {
                    App.router.pop(context);
                    App.router.navigateTo(context, '/',
                        transition: transitionDirection());
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Column(
              children: <Widget>[
                Divider(
                  height: 0.0,
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(
                    "Settings",
                    style: Theme
                        .of(context)
                        .textTheme
                        .button,
                  ),
                  onTap: () {
                    App.router.navigateTo(context, '/settings',
                        transition: transitionDirection());
                  },
                ),
                Divider(
                  height: 0.0,
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text(
                    "About",
                    style: Theme
                        .of(context)
                        .textTheme
                        .button,
                  ),
                  onTap: () {
                    App.router.navigateTo(context, '/about',
                        transition: transitionDirection());
                  },
                ),
                Divider(
                  height: 0.0,
                ),
                ListTile(
                  leading: Icon(Icons.call),
                  title: Text(
                    "Contact us",
                    style: Theme.of(context).textTheme.button,
                  ),
                  onTap: () {
                    App.router.navigateTo(context, '/contact',
                        transition: transitionDirection());
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
