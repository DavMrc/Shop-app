import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class WCartItem extends StatelessWidget {
  final CartItem _cartItem;

  WCartItem(this._cartItem);

  @override
  Widget build(BuildContext context) {
    return Dismissible(  // deletes the item if swiped
      key: ValueKey(this._cartItem.id),
      background: Container(
        padding: EdgeInsets.only(right: 20),
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => Provider.of<PCart>(context, listen: false).removeItem(this._cartItem.id),

      child: Card(
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
      ),
    );
  }
}