import 'package:flutter/cupertino.dart';
import 'package:groceryapp/model/cart.dart';

class CartProvider extends ChangeNotifier {
  List<CartItems> _items = [];
  int amount = 0;

  void addItem(CartItems item) => {
        _items.add(item),
        notifyListeners(),
      };
  List<CartItems> getItems() => _items;
  void deleteItem(CartItems item) => {
        _items.remove(item),
        notifyListeners(),
      };
  void clearItem() => {
        _items = [],
        notifyListeners(),
      };
  // int getAmount() {
  //   _items.map((e) => amount = e.amount + 1);
  //   notifyListeners();
  //   return amount;
  // }
}