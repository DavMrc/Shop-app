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
      ChangeNotifierProvider(  // products provider registered
        create: (ctx) => PProducts(),
      ),
      ChangeNotifierProvider(  // cart provider registered
        create: (ctx) => PCart(),
      ),
    ],  
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: "Lato",
        ),
        routes: {
          '/': (_) => SProducts(),
          SProductDetail.routeName: (_) => SProductDetail(),
          SCart.routeName: (_) => SCart(),
        },
      ),
    );
  }
}
