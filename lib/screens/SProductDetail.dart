import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/PProducts.dart';

class SProductDetail extends StatelessWidget {
  static const routeName = "/product-detail";

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments as String;
    Product product = Provider.of<PProducts>(context, listen: false).findById(id);

    return Scaffold(
      body: CustomScrollView( 
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.title,),
              background: Hero(
                tag: product.id,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10,),

              Text(
                "${product.price.toStringAsFixed(2)}€",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 10,),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                child: Text(
                  product.description,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),

              SizedBox(height: 800,),
            ]),
          ),
        ],
      ),
    );
  }
}