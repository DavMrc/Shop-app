import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/PProducts.dart';

class SProductDetail extends StatelessWidget {
  static const routeName = "/product-detail";

  @override
  Widget build(BuildContext context) {
    String productId = ModalRoute.of(context).settings.arguments as String;

    // since in this screen nothing would dynamically change, we set "listen: false"
    // to avoid rebuilding this widget
    Product product = Provider.of<PProducts>(context, listen: false).findById(productId);

    return Scaffold(
      appBar: AppBar(title: Text(product.title),),
    );
  }
}