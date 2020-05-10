import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../providers/PProducts.dart';
import '../screens/SNewProduct.dart';
import '../widgets/Drawer.dart';
import '../widgets/WUserProductItem.dart';


class SUserProducts extends StatelessWidget {
  static const routeName = "/user-products";

  Future<PProducts> _refreshProducts(BuildContext context) async{
    await Provider.of<PProducts>(context, listen: false).fetchProducts(filterById: true);
  }

  @override
  Widget build(BuildContext context) {
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

      body: FutureBuilder<PProducts>(
        future: this._refreshProducts(context),
        builder: (_, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if (snapshot.connectionState == ConnectionState.done){
            return Consumer<PProducts>(
              builder: (_, productProvider, __) => Padding(
                padding: const EdgeInsets.all(8),
                child: RefreshIndicator(
                  onRefresh: () => this._refreshProducts(context),
                  child: ListView.builder(
                    itemCount: productProvider.all.length,
                    itemBuilder: (_, index){
                      return WUserProductItem(productProvider.all[index]);
                    }
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}