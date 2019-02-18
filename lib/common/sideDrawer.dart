import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[Icon(Icons.landscape), Text("اللوجو")],
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("تسجيل الدخول"),
            onTap: null,
          ),
          Divider(
            height: 0.0,
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("المنتجات المفضلة"),
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
    );
  }
}
