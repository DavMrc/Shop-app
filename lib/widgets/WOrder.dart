import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/providers.dart';

class WOrder extends StatefulWidget {
  final OrderItem _order;

  WOrder(this._order);

  @override
  _WOrderState createState() => _WOrderState();
}

class _WOrderState extends State<WOrder> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("${this.widget._order.totalPrice}€"),
            subtitle: Text(DateFormat("dd-MM-yyyy").format(this.widget._order.dateTime)),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: (){},
            ),
          ),
        ],
      ),
    );
  }
}