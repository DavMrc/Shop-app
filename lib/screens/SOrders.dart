import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../widgets/WOrder.dart';
import '../widgets/Drawer.dart';
import '../providers/providers.dart';

class SOrders extends StatefulWidget {
  static const routeName = "/orders";

  @override
  _SOrdersState createState() => _SOrdersState();
}

class _SOrdersState extends State<SOrders> {
  bool _isLoading = true;

  @override
  void initState() {
    Provider.of<POrders>(context, listen: false).fetchOrders()
    .then((_){
      setState(() {
        this._isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ordersProvider = Provider.of<POrders>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Your orders"),),
      drawer: WDrawer(),
      body: ordersProvider.orders.isEmpty
      ? Center(child: CircularProgressIndicator(),)
      : ListView.builder(
        itemCount: ordersProvider.orders.length,
        itemBuilder: (ctx, index){
          return WOrder(ordersProvider.orders[index]);
        },
      ),
    );
  }
}