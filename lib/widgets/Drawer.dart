import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/screens.dart';
import '../providers/PAuth.dart';

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

          Spacer(),

          ListTile(
            title: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Logout",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).errorColor,
                ),
              ),
            ),
            trailing: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).errorColor,
              size: 35,  
            ),
            onTap: () {
              Provider.of<PAuth>(context, listen: false).logout();
            }
          ),
        ],
      ),
    );
  }
}