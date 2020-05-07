import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/PProducts.dart';
import '../screens/SNewProduct.dart';


class WUserProductItem extends StatelessWidget {
  final Product _product;

  WUserProductItem(this._product);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(this._product.id),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: EdgeInsets.only(right: 20),
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete, color: Colors.white, size: 40,),
        alignment: Alignment.centerRight,
      ),
      onDismissed: (_) {
        Provider.of<PProducts>(context, listen: false).removeProduct(this._product.id);
      },
      confirmDismiss: (_){
        return showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(  // mostra un widget di conferma Y/N
              title: Text("Warning"),
              content: Text("Do you want to delete this product?"),
              actions: <Widget>[
                FlatButton(child: Text("No"), onPressed: () => Navigator.of(context).pop(false),),
                FlatButton(child: Text("Yes"), onPressed: () => Navigator.of(context).pop(true),),
              ],
            );
          }
        );
      },
      
      child: Card(
        elevation: 4,
        child: Padding(
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

            trailing: IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  SNewProduct.routeName,
                  arguments: this._product.id
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}