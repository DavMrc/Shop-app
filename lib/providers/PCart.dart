import "package:flutter/foundation.dart";


class CartItem{
  final String id;
  final String title;
  final double price;
  int quantity;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    this.quantity = 1,
  });

  String toString() {
    return "CartItem #"+this.id;
  }
}


class PCart with ChangeNotifier{
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items{
    return {..._items};
  }

  void addItem(String _id, String _title, double _price){
    if(this._items.containsKey(_id)){
      this._items[_id].quantity ++;
    }else{
      var newItem =  CartItem(
        id: _id,
        title:  _title,
        price: _price,
        quantity: 1,
      );
      this._items[_id] = newItem;
    }

    notifyListeners();
  }

  int get itemCount{
    if(this._items.isEmpty) return 0;

    int count = 0;
    for(var item in this._items.values){
      count += item.quantity;
    }

    return count;
  }

  double get totalPrice{
    var total = 0.0;
    this._items.forEach((key, value){
      total += value.price * value.quantity;
    });

    return total;
  }

  void removeItem(String productId, {int quantity=-1}){
    var prod = this._items[productId];
    if(quantity == -1 || prod.quantity >= quantity) this._items.remove(productId);
    else{
      prod.quantity -= quantity;
    }

    notifyListeners();
  }

  void clear(){
    this._items.clear();

    notifyListeners();
  }
}