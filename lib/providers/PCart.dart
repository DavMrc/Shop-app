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
        id: DateTime.now().toString(),
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
}