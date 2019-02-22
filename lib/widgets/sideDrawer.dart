import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Column(
              // TODO Username, User avatar
              children: <Widget>[
                Icon(Icons.account_circle),
                SizedBox(height: 10.0),
                Text('Login/Sign up'),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
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
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/');
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
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/vendors');
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
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/favourites');
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
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/history');
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
                    Navigator.pushNamed(context, '/settings');
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
                    Navigator.pushNamed(context, '/about');
                  },
                ),
                Divider(
                  height: 0.0,
                ),
                ListTile(
                  leading: Icon(Icons.report_problem),
                  title: Text(
                    "Report bug",
                    style: Theme.of(context).textTheme.button,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/contact');
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
