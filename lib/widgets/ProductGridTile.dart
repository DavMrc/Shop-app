import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/SProductDetail.dart';
import '../providers/providers.dart';

class ProductGridTile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Product product = Provider.of<Product>(context);
    PCart cart = Provider.of<PCart>(context, listen: false);
    final authProvider = Provider.of<PAuth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        header: null,

        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
            SProductDetail.routeName, arguments: product.id
          ),
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage("assets/images/product_placeholder.png"),
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),

        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(product.title, textAlign: TextAlign.center,),

          leading: IconButton(
            color: Theme.of(context).accentColor,
            icon: product.isFavorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
            onPressed: () => product.toggleFavorite(authProvider.token, authProvider.userId)
          ),

          trailing: IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.title, product.price);
              
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Product added"),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: "Remove",
                    onPressed: () => cart.removeItem(product.id),
                  ),
                  behavior: SnackBarBehavior.floating,

                ),
              );
            },
          ),
        ),
      ),
    );
  }
}