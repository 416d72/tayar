import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tayar/screens/cartPage.dart';
import 'package:tayar/screens/historyPage.dart';
import 'package:tayar/screens/index.dart';
import 'package:tayar/screens/theme.dart';
import 'package:tayar/widgets/sideDrawer.dart';
import 'package:tayar/widgets/topBar.dart';

void main() {
  // Force portrait mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Layout direction
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        Locale("ar", "EG"),
      ],
      locale: Locale("ar", "EG"),
      title: 'Tayar',
      theme: customTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;
  final List _pages = [Index(), CartPage(), HistoryPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      key: _scaffoldKey,
      appBar: topBar(),
      body: _pages[_currentPage],
      drawer: SideDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: updateCurrentPage,
        currentIndex: _currentPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Theme
                  .of(context)
                  .accentColor,
            ),
            title: Text(
              "المنتجات",
              style: Theme
                  .of(context)
                  .textTheme
                  .subhead,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text(
              "السلة",
              style: Theme
                  .of(context)
                  .textTheme
                  .subhead,
            ),
            activeIcon: Icon(
              Icons.shopping_cart,
              color: Theme
                  .of(context)
                  .accentColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text(
              "الطلبات السابقة",
              style: Theme
                  .of(context)
                  .textTheme
                  .subhead,
            ),
            activeIcon: Icon(
              Icons.history,
              color: Theme
                  .of(context)
                  .accentColor,
            ),
          ),
        ],
      ),
    );
  }

  void updateCurrentPage(int index) {
    setState(() {
      _currentPage = index;
    });
  }
}
