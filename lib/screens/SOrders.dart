import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../widgets/WOrder.dart';
import '../providers/providers.dart';

class SOrders extends StatelessWidget {
  static const routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<POrders>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Your orders"),),
      body: ListView.builder(
        itemCount: ordersProvider.orders.length,
        itemBuilder: (ctx, index){
          return WOrder(ordersProvider.orders[index]);
        },
      ),
    );
  }
}