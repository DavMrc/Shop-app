import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/WCartItem.dart';
import '../providers/providers.dart';

class SCart extends StatelessWidget {
  static const routeName = "/cart";

  void submitOrder(BuildContext ctx, PCart cartProvider){
    if(cartProvider.items.values.toList().isEmpty){
      showDialog(
        context: ctx,
        builder: (_) => AlertDialog(
          title: Text("Cart empty!"),
          content: Text("You submitted an empty order! Add some products first!"),
          actions: <Widget>[
            FlatButton(child: Text("Okay"), onPressed: () => Navigator.of(ctx).pop(),)
          ],
        )
      );
    }
    else{
      Provider.of<POrders>(ctx, listen: false).addOrder(
        cartProvider.items.values.toList()
      );

      cartProvider.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<PCart>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Your cart"),),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total", style: TextStyle(fontSize: 20),),

                  Spacer(),

                  Chip(
                    label: Text(
                      "${cartProvider.totalPrice}€",
                      style: Theme.of(context).primaryTextTheme.headline6,
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),

                  FlatButton(
                    child: Text("Order now"),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () => this.submitOrder(context, cartProvider),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 10,),

          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (ctx, index){
                var item = cartProvider.items.values.toList()[index];
                return WCartItem(item);
              },
            ),
          ),

        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => cartProvider.clear(),
        child: Icon(Icons.delete),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }
}