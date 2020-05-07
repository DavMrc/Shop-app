import 'package:flutter/material.dart';

import '../screens/screens.dart';

class WDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Hello friend!"),
            automaticallyImplyLeading: false,
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Shop"),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),

           ListTile(
            leading: Icon(Icons.payment),
            title: Text("Orders"),
            onTap: () => Navigator.of(context).pushReplacementNamed(SOrders.routeName),
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Manage products"),
            onTap: () => Navigator.of(context).pushReplacementNamed(SUserProducts.routeName),
          ),
        ],
      ),
    );
  }
}