import 'package:flutter/material.dart';

import './screens/SProductDetail.dart';
import './screens/SProducts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
