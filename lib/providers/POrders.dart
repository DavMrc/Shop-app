import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import "dart:convert";

import '../providers/PCart.dart';


class OrderItem{
  final String id;
  final double totalPrice;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.totalPrice,
    @required this.products,
    @required this.dateTime,
  });

  static OrderItem fromMap(Map<String, dynamic> map){
    return OrderItem(
      dateTime: map['dateTime'].runtimeType == String ? DateTime.parse(map['dateTime']) : map['dateTime'],
      id: map['id'],
      products: map['products'],
      totalPrice: map['totalPrice'],
    );
  }

  Map<String, dynamic> toMap({noId: false}){
    if(noId){
      return {
        'totalPrice': this.totalPrice,
        'products': this.products,
        'dateTime': this.dateTime,
      };
    }

    return {
      'id': this.id,
      'totalPrice': this.totalPrice,
      'products': this.products,
      'dateTime': this.dateTime,
    };
  }

  @override
  int get hashCode => this.id.hashCode;

  @override
  bool operator ==(dynamic other){
    return this.id == other.id;
  }
}


class POrders with ChangeNotifier{
  List<OrderItem> _orders = [];
  static const baseURL = "https://flutter-shop-6f582.firebaseio.com/orders";

  List<OrderItem> get orders {
    return [...this._orders];
  }

  Future<void> addOrder(List<CartItem> items) async {
    var total = 0.0;
    items.forEach((it){
      total += it.price;
    });

    var orderMap = {
      'totalPrice': total,
      'dateTime': DateTime.now().toString(),
      'products': items,
    };

    try{
      final response = await http.post(
        POrders.baseURL+'.json',
        body: json.encode(orderMap)
      );
      orderMap['id'] = json.decode(response.body)['name'];

      _orders.insert(0, OrderItem.fromMap(orderMap));
    }catch(error){
      throw error;
    }

    notifyListeners();
  }

  Future<void> fetchOrders() async {
    try{
      final response = await http.get(POrders.baseURL+'.json');
      final orders = json.decode(response.body) as Map<String, dynamic>;

      if (orders == null) return;  // no orders to be fetched

      orders.forEach((key, value) {
        var newOrder = OrderItem(
          id: key,
          dateTime: DateTime.parse(value['dateTime']),
          totalPrice: value['totalPrice'],
          products: (value['products'] as List<dynamic>).map((i){
            return CartItem(id: i['id'], price: i['price'], title: i['title'], quantity: i['quantity']);
          }).toList(),
        );

        if(! this.orders.contains(newOrder)) this._orders.add(newOrder);
      });

      notifyListeners();
    }catch(error){
      throw error;
    }
  }
}