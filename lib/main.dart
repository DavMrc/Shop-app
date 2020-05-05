import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/SProductDetail.dart';
import './screens/SProducts.dart';
import './providers/PProducts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(    // products provider
      create: (ctx) => PProducts(),    // provider registered
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
        },
      ),
    );
  }
}
