import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../widgets/Badge.dart';
import '../widgets/ProductGridTile.dart';

enum FilterOptions{
  favorites,
  all,
}

class SProducts extends StatefulWidget {
  @override
  _SProductsState createState() => _SProductsState();
}

class _SProductsState extends State<SProducts> {
  bool _showFavorites = false;

  void showFavorites(){
    setState(() {
      this._showFavorites = true;
    });
  }

  void showAll(){
    setState(() {
      this._showFavorites = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My products"),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions option){
              if(option == FilterOptions.favorites){
                this.showFavorites();
              }else{
                this.showAll();
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Only favorites"),
                value: FilterOptions.favorites,
              ),
              PopupMenuItem(
                child: Text("Show all"),
                value: FilterOptions.all,
              ),
            ]
          ),

          Consumer<PCart>(
            builder: (ctx, cartData, ch) => Badge(
              child: ch,  // avoids rebuilding the Icon
              value: cartData.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
          ),
        ],
      ),

      body: ProductsGrid(this._showFavorites),
    );
  }
}


class ProductsGrid extends StatelessWidget {
  bool showFavorites;

  ProductsGrid(this.showFavorites);

  @override
  Widget build(BuildContext context) {
    List<Product> products;

    if(this.showFavorites){
      products = Provider.of<PProducts>(context).favorites;
    }else{
      products = Provider.of<PProducts>(context).all;
    }

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (ctx, index){
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductGridTile(),
        );
      },
    );
  }
}
