import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

import '../providers/providers.dart';

class WOrder extends StatefulWidget {
  final OrderItem _order;

  WOrder(this._order);

  @override
  _WOrderState createState() => _WOrderState();
}

class _WOrderState extends State<WOrder> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("${this.widget._order.totalPrice.toStringAsFixed(2)}€"),
            subtitle: Text(DateFormat("dd-MM-yyyy").format(this.widget._order.dateTime)),
            trailing: IconButton(
              icon: this._expanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
              onPressed: (){
                setState(() {
                  this._expanded = !this._expanded;
                });
              },
            ),
          ),

          if (_expanded) Container(
            padding: const EdgeInsets.symmetric(horizontal:15, vertical:4),
            height: min(widget._order.products.length * 20.0 + 100, 100),
            child: ListView.builder(
              itemCount: widget._order.products.length,

              itemBuilder: (ctx, index){
                var cprod = widget._order.products[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      cprod.title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                    Text(
                      "${cprod.quantity}x ${cprod.price}€",
                      style: TextStyle(fontSize: 18, color: Colors.grey,),
                    )
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}