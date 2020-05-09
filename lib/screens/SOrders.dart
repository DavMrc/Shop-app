import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../widgets/WOrder.dart';
import '../widgets/Drawer.dart';
import '../providers/providers.dart';

class SOrders extends StatelessWidget {
  static const routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your orders"),),
      drawer: WDrawer(),
      body: FutureBuilder(
        future: Provider.of<POrders>(context, listen: false).fetchOrders(),

        builder: (_, futureResult){
          if(futureResult.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          else if (futureResult.connectionState == ConnectionState.done) {
            return Consumer<POrders>(
              builder: (_, orderProvider, child){
                return ListView.builder(
                  itemCount: orderProvider.orders.length,
                  itemBuilder: (ctx, index){
                    return WOrder(orderProvider.orders[index]);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}