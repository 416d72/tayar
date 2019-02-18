import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tayar/common/search.dart';
import 'package:tayar/common/sideDrawer.dart';
import 'package:tayar/user/cartPage.dart';
import 'package:tayar/user/mainPage.dart';
import 'package:tayar/user/preferencesPage.dart';

void main() {
  // Force portrait mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Main app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
      // General app settings
      title: 'Flutter Demo',
      theme:
      ThemeData(primarySwatch: Colors.deepOrange, fontFamily: 'Frutiger'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;
  final List<Widget> _pages = [MainPage(), CartPage(), PreferencesPage()];
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
//      key: _scaffoldKey,
      appBar: AppBar(
        leading: Builder(
            builder: (context) => IconButton(
                  icon: Icon(Icons.dehaze),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                )),
        title: SearchFieldWidget(),
      ),
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
                color: Theme.of(context).accentColor,
              ),
              title: Text("تسوق")),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text("سلة المشتريات"),
            activeIcon: Icon(
              Icons.shopping_cart,
              color: Theme
                  .of(context)
                  .accentColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text("الطلبات السابقة"),
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
