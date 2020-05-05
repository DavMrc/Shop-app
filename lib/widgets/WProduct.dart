import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/SProductDetail.dart';
import '../providers/PProducts.dart';
import '../models/product.dart';

class WProduct extends StatelessWidget {
  final String _productId;

  WProduct(this._productId);

  @override
  Widget build(BuildContext context) {
    Product product = Provider.of<PProducts>(context).findById(this._productId);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        header: null,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
            SProductDetail.routeName, arguments: this._productId
          ),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(product.title, textAlign: TextAlign.center,),
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