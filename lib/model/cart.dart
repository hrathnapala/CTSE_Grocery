import 'package:flutter/cupertino.dart';
import 'package:groceryapp/model/data.dart';

class CartItems {
  Items item;
  int amount;
  bool isCompleted;

  CartItems(
      {@required this.item, @required this.amount, this.isCompleted = false});
}
