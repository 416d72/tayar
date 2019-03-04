import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:tayar/screens/about.dart';
import 'package:tayar/screens/browse.dart';
import 'package:tayar/screens/cart.dart';
import 'package:tayar/screens/contact.dart';
import 'package:tayar/screens/favourites.dart';
import 'package:tayar/screens/index.dart';
import 'package:tayar/screens/login.dart';
import 'package:tayar/screens/orders.dart';
import 'package:tayar/screens/register.dart';
import 'package:tayar/screens/settings.dart';
import 'package:tayar/screens/vendors.dart';
// Screens

var indexHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return Index();
});

var aboutHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AboutPage();
});
var cartHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CartPage();
});
var contactHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ContactPage();
});
var favouritesHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return FavouritesPage();
});
var ordersHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return OrdersPage();
});
var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginPage();
});
var registerHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RegisterPage();
});
var settingsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SettingsPage();
});
var vendorsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return VendorsPage();
});

var browseHandler = new Handler(
    type: HandlerType.function,
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String collection = params["collection"]?.first;
      String parent = params["parent"]?.first;
      showDialog(
        context: context,
        builder: (context) {
          return BrowsePage(
            collection: collection,
            parent: parent,
            fancy: false,
          );
        },
      );
    });
