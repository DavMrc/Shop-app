import 'package:flutter/cupertino.dart';

import '../models/product.dart';
import '../models/dummy_data.dart';

class PProducts with ChangeNotifier{
  List<Product> _products = DUMMY_PRODUCTS;

  List<Product> get items{
    return [..._products];  // ritorna una copia, NON l'oggetto stesso
  }

  Product findById(String id){
    return this._products.firstWhere((prod){
      return id == prod.id;
    });
  }

  void addProduct(Product p){
    this._products.add(p);

    notifyListeners();  // avvisa che ci sono stati dei cambiamenti
  }
}