import 'package:flutter/material.dart';

import '../models/dummy_data.dart';
import '../widgets/WProduct.dart';

class SProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My products"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: DUMMY_PRODUCTS.length,
        itemBuilder: (ctx, index){
          return WProduct(DUMMY_PRODUCTS[index]);
        },
      ),
    );
  }
}