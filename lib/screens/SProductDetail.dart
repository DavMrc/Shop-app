import 'package:flutter/material.dart';

import '../models/product.dart';

class SProductDetail extends StatelessWidget {
  static const routeName = "/product-detail";

  @override
  Widget build(BuildContext context) {
    final Product _product = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text(_product.title),),
    );
  }
}