import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tayar/app.dart';
import 'package:tayar/routing/routes.dart';

void main() {
  // Force portrait mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  MyAppState() {
    final router = new Router();
    Routes.configureRoutes(router);
    App.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Layout direction
//      localizationsDelegates: [
//        GlobalMaterialLocalizations.delegate,
//        GlobalWidgetsLocalizations.delegate
//      ],
//      supportedLocales: [
//        Locale("ar", "EG"),
//      ],
//      locale: Locale("ar", "EG"),
      title: 'Tayar',
      theme: customTheme(),
      onGenerateRoute: App.router.generator,
    );
  }
}

//class MyHomePage extends StatefulWidget {
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _currentPage = 0;
//  final List _pages = [Index(), CartPage(), HistoryPage()];
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
////      key: _scaffoldKey,
//      appBar: topBar(),
//      body: _pages[_currentPage],
//      drawer: SideDrawer(),
//      bottomNavigationBar: BottomNavigationBar(
//        onTap: updateCurrentPage,
//        currentIndex: _currentPage,
//        items: [
//          BottomNavigationBarItem(
//            icon: Icon(
//              Icons.home,
//            ),
//            activeIcon: Icon(
//              Icons.home,
//              color: Theme.of(context).accentColor,
//            ),
//            title: Text(
//              "Home",
//              style: Theme.of(context).textTheme.subhead,
//            ),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.shopping_cart),
//            title: Text(
//              "Cart",
//              style: Theme.of(context).textTheme.subhead,
//            ),
//            activeIcon: Icon(
//              Icons.shopping_cart,
//              color: Theme.of(context).accentColor,
//            ),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.history),
//            title: Text(
//              "History",
//              style: Theme.of(context).textTheme.subhead,
//            ),
//            activeIcon: Icon(
//              Icons.history,
//              color: Theme.of(context).accentColor,
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  void updateCurrentPage(int index) {
//    setState(() {
//      _currentPage = index;
//    });
//  }
//}
