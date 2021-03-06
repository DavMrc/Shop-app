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

  Map<String, dynamic> toMap({noId:false}){
    if(noId){
      return {
        'title': this.title,
        'description': this.description,
        'price': this.price,
        'imageUrl': this.imageUrl,
        'isFavorite': this.isFavorite,
      };
    }

    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'price': this.price,
      'imageUrl': this.imageUrl,
      'isFavorite': this.isFavorite,
    };
  }

  Future<void> toggleFavorite(String token, String userId) async {
    this.isFavorite = !this.isFavorite;

    try{
      await http.put(
        PProducts.baseURL+'/favorites/$userId/${this.id}.json?auth=$token',
        body: json.encode(this.isFavorite)
      );
    }catch(error){
      throw error;
    }

    notifyListeners();
  }

  @override
  int get hashCode => this.id.hashCode;

  @override
  bool operator ==(dynamic other){
    return this.id == other.id;
  }
}


// ----------------PRODUCTS PROVIDER

class PProducts with ChangeNotifier{
  static const baseURL = "https://flutter-shop-6f582.firebaseio.com";
  final _authToken;
  final _userId;
  List<Product> _products = [];

  PProducts(this._userId, this._authToken, this._products);

  List<Product> get favorites{
    return _products.where((prod){
      return prod.isFavorite;
    }).toList();
  }  

  List<Product> get all{
    if (this._products.isEmpty) return [];
    return [...this._products];  // ritorna una copia
  }

  Future<void> fetchProducts({bool filterById: false}) async{
    this._products.clear();

    final filterQuery = filterById ? 'orderBy="creatorId"&equalTo="${this._userId}"' : '';
    
    try{
      final productsResponse = await http.get(
        baseURL+'/products.json?auth=${this._authToken}&$filterQuery'
      );
      final products = json.decode(productsResponse.body) as Map<String, dynamic>;

      if(products == null){}  // no item was received
      else{
        final favoritesResponse = await http.get(
          baseURL+'/favorites/${this._userId}.json?auth=${this._authToken}',
        );
        final favoriteData = json.decode(favoritesResponse.body);

        products.forEach((key, value){
          var newProd = Product(
            id: key,
            title: value['title'],
            description: value['description'],
            imageUrl: value['imageUrl'],
            price: value['price'],
            isFavorite: favoriteData == null ? false : favoriteData[key] ?? false,
          );
          this._products.add(newProd);
          // if(! this._products.contains(newProd)) this._products.add(newProd);
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
      final response = await http.post(
        PProducts.baseURL+"/products.json?auth=${this._authToken}",
        body: json.encode(product)
      );
      product['id'] = json.decode(response.body)['name'];
      this._products.add(Product.fromMap(product));

      notifyListeners();
    }catch(error){
      throw error;
    }
  }

  Future<void> removeProduct(String id) async{
    this._products.removeWhere((prod) => prod.id == id);

    try{
      await http.delete(PProducts.baseURL+"/products/$id.json?auth=${this._authToken}");
    }catch(error){

    }

    notifyListeners();
  }

  Future<void> editProduct(String id, Map<String, dynamic> product) async{
    final prodIndex = this._products.indexWhere((p) => p.id == id);
    this._products[prodIndex] = Product.fromMap(product);

    try{
      await http.patch(PProducts.baseURL+"/products/$id.json?auth=${this._authToken}", body: json.encode(product));
    }catch(error){
      throw error;
    }

    notifyListeners();
  }
}
