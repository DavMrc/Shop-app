import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/WCartItem.dart';
import '../providers/providers.dart';

class SCart extends StatelessWidget {
  static const routeName = "/cart";

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
                      style: Theme.of(context).primaryTextTheme.title,
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),

                  FlatButton(
                    child: Text("Order now"),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: (){},
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