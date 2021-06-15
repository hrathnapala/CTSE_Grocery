import 'package:flutter/cupertino.dart';
import 'package:groceryapp/model/data.dart';

class CartItems {
  Items item;
  int amount;
  bool isCompleted;

  CartItems(
      {@required this.item, @required this.amount, this.isCompleted = false});

  CartItems.fromMap(Map<String, dynamic> data) {
    // item.imageUrl = data['imageUrl'];
    // item.name = data['name'];
    // item.price = data['price'];
    // item.type = data['type'];
    item = Items(
        imageUrl: data['imageUrl'],
        name: data['name'],
        price: data['price'],
        type: data['type']);
    amount = data['amount'];
    isCompleted = data['isCompleted'];
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': item.imageUrl,
      'name': item.name,
      'price': item.price,
      'type': item.type,
      'amount': amount,
      'isCompleted': isCompleted,
    };
  }
}
