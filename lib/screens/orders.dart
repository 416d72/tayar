import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:tayar/widgets/scaffold.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<OrdersPage> {
  var _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Order history',
      body: LiquidPullToRefresh(
        key: _refreshKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
          children: <Widget>[
            Container(
              child: Center(
                child: Text("Coming soon ..."),
              ),
            ),
          ],
        ),
        onRefresh: _refresh,
        showChildOpacityTransition: true,
      ),
    );
  }

  @protected
  Future<void> _refresh() async {
    _refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 1));
    // TODO: fetch history from database
    // TODO: Implement 3 top tabs (Wait list - Scheduled - History)
    return null;
  }
}
