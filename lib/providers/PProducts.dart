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
  static const prodsURL = "https://flutter-shop-6f582.firebaseio.com/products.json";

  List<Product> _products = [];
  // List<Product> _products = [
  //   Product(
  //     id: 'p0',
  //     title: 'Red Shirt',
  //     description: 'A red shirt - it is pretty red!',
  //     price: 29.99,
  //     imageUrl:
  //         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  //   ),
  //   Product(
  //     id: 'p1',
  //     title: 'Trousers',
  //     description: 'A nice pair of trousers.',
  //     price: 59.99,
  //     imageUrl:
  //         'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
  //   ),
  //   Product(
  //     id: 'p2',
  //     title: 'Yellow Scarf',
  //     description: 'Warm and cozy - exactly what you need for the winter.',
  //     price: 19.99,
  //     imageUrl:
  //         'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
  //   ),
  //   Product(
  //     id: 'p3',
  //     title: 'A Pan',
  //     description: 'Prepare any meal you want.',
  //     price: 49.99,
  //     imageUrl:
  //         'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
  //   ),
  // ];

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
      final response = await http.get(PProducts.prodsURL);
      final products = json.decode(response.body) as Map<String, dynamic>;

      products.forEach((key, value){
        var newProd = Product(
          id: value['id'],
          title: value['title'],
          description: value['description'],
          imageUrl: value['imageUrl'],
          price: value['price'],
          isFavorite: value['isFavorite'],
        );
        if(! this._products.contains(newProd)) this._products.add(newProd);
      });

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

  Future<void> addProduct(Product product) async{
    this._products.add(product);

    try{
      await http.post(PProducts.prodsURL, body: json.encode(product.toMap()));

      notifyListeners();  // avvisa che ci sono stati dei cambiamenti
    }catch(error){
      throw error;
    }
  }

  void removeProduct(String id){
    this._products.removeWhere((prod) => prod.id == id);

    notifyListeners();
  }

  void editProduct(Product product){
    final prodIndex = this._products.indexWhere((p) => p.id == product.id);
    this._products[prodIndex] = product;

    notifyListeners();
  }
}
