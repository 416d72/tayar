import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HistoryPage extends StatefulWidget {
  @override
  _History createState() => _History();
}

class _History extends State<HistoryPage> {
  var _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      key: _refreshKey,
      child: ListView(
        padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
        children: <Widget>[
          Center(
            child: Text("الطلبات السابقة"),
          ),
        ],
      ),
      onRefresh: _refresh,
      showChildOpacityTransition: true,
    );
  }

  @protected
  Future<void> _refresh() async {
    _refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 1));
    // TODO: fetch history from database
    return null;
  }
}
