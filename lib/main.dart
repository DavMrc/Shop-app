import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/screens.dart';
import './providers/providers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(    
    providers: [
      // TODO: these might become ChangeNotifierProvider.value()
      ChangeNotifierProvider(  // products provider
        create: (ctx) => PProducts(),
      ),
      ChangeNotifierProvider(  // cart provider
        create: (ctx) => PCart(),
      ),
      ChangeNotifierProvider( // orders provider
        create: (_) => POrders(),
      ),
      ChangeNotifierProvider(
        create: (_) => PAuth(),
      )
    ],  
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: "Lato",
        ),
        routes: {
          // '/': (_) => SProducts(),
          '/': (_) => SAuthScreen(),
          SProductDetail.routeName: (_) => SProductDetail(),
          SCart.routeName: (_) => SCart(),
          SOrders.routeName: (_) => SOrders(),
          SUserProducts.routeName: (_) => SUserProducts(),
          SNewProduct.routeName: (_) => SNewProduct(),
        },
      ),
    );
  }
}
