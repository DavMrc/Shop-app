import 'package:flutter/material.dart';

import '../screens/SProductDetail.dart';
import '../models/product.dart';

class WProduct extends StatelessWidget {
  final Product _product;

  WProduct(this._product);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        header: null,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
            SProductDetail.routeName, arguments: this._product
          ),
          child: Image.network(
            _product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(this._product.title, textAlign: TextAlign.center,),
          leading: IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.favorite),
            onPressed: (){},
          ),
          trailing: IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.shopping_cart),
            onPressed: (){},
          ),
        ),
      ),
    );
  }
}