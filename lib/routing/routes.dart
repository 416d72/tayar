import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:tayar/routing/handlers.dart';

class Routes {
  static String root = "/";
  static String browse = "/browse";
  static String fancyBrowse = "/browse/fancy";
  static String about = "/about";
  static String cart = "/cart";
  static String contact = "/contact";
  static String favourites = "/favourites";
  static String history = "/history";
  static String login = "/login";
  static String settings = "/settings";
  static String vendors = "/vendors";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: indexHandler);
    router.define(browse, handler: browseHandler);
    router.define(about, handler: aboutHandler);
    router.define(cart, handler: cartHandler);
    router.define(contact, handler: contactHandler);
    router.define(favourites, handler: favouritesHandler);
    router.define(history, handler: historyHandler);
    router.define(login, handler: loginHandler);
    router.define(settings, handler: settingsHandler);
    router.define(vendors, handler: vendorsHandler);
  }
}
