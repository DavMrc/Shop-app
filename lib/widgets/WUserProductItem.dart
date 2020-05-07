import 'package:flutter/material.dart';

import '../providers/PProducts.dart';


class WUserProductItem extends StatelessWidget {
  final Product _product;

  WUserProductItem(this._product);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: FittedBox(
          fit: BoxFit.cover,
          child: CircleAvatar(
            backgroundImage: NetworkImage(this._product.imageUrl),
            minRadius: 25,
          ),
        ),

        title: Text(this._product.title),

        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                color: Theme.of(context).primaryColor,
                onPressed: (){},
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}