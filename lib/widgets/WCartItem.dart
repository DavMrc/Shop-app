import 'package:flutter/material.dart';
import '../providers/PCart.dart';

class WCartItem extends StatelessWidget {
  final CartItem _cartItem;

  WCartItem(this._cartItem);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: FittedBox(child: Text("${this._cartItem.price}€")),
            ),
          ),
          title: Text(this._cartItem.title),
          subtitle: Text("Total: ${this._cartItem.price * this._cartItem.quantity}€"),
          trailing: Text("${this._cartItem.quantity}x"),
        ),
      ),
    );
  }
}