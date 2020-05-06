import 'package:flutter/foundation.dart';
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
}


class POrders with ChangeNotifier{
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [...this._orders];
  }

  void addOrder(List<CartItem> items){
    var total = 0.0;
    items.forEach((it){
      total += it.price;
    });

    var newOrder = OrderItem(
      id: DateTime.now().toString(),
      totalPrice: total,
      dateTime: DateTime.now(),
      products: items,
    );
    _orders.insert(0, newOrder);

    notifyListeners();
  }
}