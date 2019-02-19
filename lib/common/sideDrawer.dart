import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  final String userName = "عمرو";

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
                FlatButton(
                  child: Text("تسجيل الدخول"),
                  onPressed: () => null,
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text("المنتجات المفضلة"),
                  onTap: null,
                ),
                Divider(
                  height: 0.0,
                ),
                ListTile(
                  leading: Icon(Icons.store),
                  title: Text("المتاجر"),
                  onTap: null,
                ),
                Divider(
                  height: 0.0,
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("الإعدادات"),
                  onTap: null,
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
                  leading: Icon(Icons.report_problem),
                  title: Text("بلغ عن مشكلة"),
                  onTap: null,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
