import 'package:flutter/cupertino.dart';
import 'package:groceryapp/model/data.dart';

class CartItems {
  String id;
  Items item;
  int amount;
  bool isCompleted;

  CartItems(
      {@required this.id,
      @required this.item,
      @required this.amount,
      this.isCompleted = false});

  CartItems.fromMap(Map<String, dynamic> data) {
    item = Items(
        imageUrl: data['imageUrl'],
        name: data['name'],
        price: data['price'],
        type: data['type']);
    amount = data['amount'];
    isCompleted = data['isCompleted'];
    id = data['id'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': item.imageUrl,
      'name': item.name,
      'price': item.price,
      'type': item.type,
      'amount': amount,
      'isCompleted': isCompleted,
    };
  }
}
