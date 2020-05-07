import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../providers/PProducts.dart';
import '../screens/SNewProduct.dart';
import '../widgets/Drawer.dart';
import '../widgets/WUserProductItem.dart';


class SUserProducts extends StatelessWidget {
  static const routeName = "/user-products";

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<PProducts>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your products"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(SNewProduct.routeName),
          ),
        ],
      ),

      drawer: WDrawer(),

      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productProvider.all.length,
          itemBuilder: (_, index){
            return WUserProductItem(productProvider.all[index]);
          }
        ),
      ),
    );
  }
}