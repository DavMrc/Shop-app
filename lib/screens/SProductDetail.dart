import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/PProducts.dart';

class SProductDetail extends StatelessWidget {
  static const routeName = "/product-detail";

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments as String;
    Product product = Provider.of<PProducts>(context).findById(id);

    return Scaffold(
      appBar: AppBar(title: Text(product.title),),
    );
  }
}