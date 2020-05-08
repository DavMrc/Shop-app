import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import "dart:convert";

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  static Product fromMap(Map<String, dynamic> product){
    try{
      return Product(
        id: product['id'],
        description: product['description'],
        imageUrl: product['imageUrl'],
        price: product['price'],
        title: product['title'],
        isFavorite: product['isFavorite'] == null ? product['isFavorite'] : false,
      );
    }catch(error){
      throw error;
    }
  }

  void toggleFavorite(){
    this.isFavorite = !this.isFavorite;

    notifyListeners();
  }

  Map<String, dynamic> toMap(){
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'price': this.price,
      'imageUrl': this.imageUrl,
      'isFavorite': this.isFavorite,
    };
  }

  @override
  int get hashCode => this.id.hashCode;

  @override
  bool operator ==(dynamic other){
    return this.id == other.id;
  }
}

class PProducts with ChangeNotifier{
  static const prodsURL = "https://flutter-shop-6f582.firebaseio.com/products";

  List<Product> _products = [];

  List<Product> get favorites{
    return _products.where((prod){
        return prod.isFavorite;
      }).toList();
  }  

  List<Product> get all{
    return [..._products];  // ritorna una copia, NON l'oggetto stesso
  }

  Future<void> fetchProducts() async{
    try{
      final response = await http.get(PProducts.prodsURL+".json");
      final products = json.decode(response.body) as Map<String, dynamic>;

      if(products == null){}  // no item was received
      else{
        products.forEach((key, value){
          var newProd = Product(
            id: key,
            title: value['title'],
            description: value['description'],
            imageUrl: value['imageUrl'],
            price: value['price'],
            isFavorite: value['isFavorite'],
          );
          if(! this._products.contains(newProd)) this._products.add(newProd);
        });
      }

      notifyListeners();
    }catch(error){
      throw error;
    }
  }

  Product findById(String id){
    return this._products.firstWhere((prod){
      return id == prod.id;
    });
  }

  Future<void> addProduct(Map<String, dynamic> product) async{
    try{
      final response = await http.post(PProducts.prodsURL+".json", body: json.encode(product));
      product['id'] = json.decode(response.body)['name'];
      this._products.add(Product.fromMap(product));

      notifyListeners();  // avvisa che ci sono stati dei cambiamenti
    }catch(error){
      throw error;
    }
  }

  Future<void> removeProduct(String id) async{
    this._products.removeWhere((prod) => prod.id == id);

    try{
      await http.delete(PProducts.prodsURL+"/$id.json");
    }catch(error){

    }

    notifyListeners();
  }

  Future<void> editProduct(Map<String, dynamic> product) async{
    final prodIndex = this._products.indexWhere((p) => p.id == product['id']);
    this._products[prodIndex] = Product.fromMap(product);

    try{
      await http.patch(PProducts.prodsURL+"/${product['id']}.json", body: json.encode(product));
    }catch(error){
      throw error;
    }

    notifyListeners();
  }
}
