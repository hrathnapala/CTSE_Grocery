import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:groceryapp/api/flutterfire.dart';
import 'package:groceryapp/model/cart.dart';
import 'package:groceryapp/model/data.dart';

class CartProvider extends ChangeNotifier {
  List<CartItems> _items = [];
  int amount = 0;
  List<Items> foods = [];
  Items _currentFood;

  void addItem(CartItems item) => {
        _items.add(item),
        notifyListeners(),
      };
  List<CartItems> getItems() => _items;

  set setCart(List<CartItems> cartList) {
    _items = cartList;
    notifyListeners();
  }

  void deleteItem(CartItems item) async {
    _items.remove(item);
    notifyListeners();
  }

  void clearItem() => {
        _items = [],
        notifyListeners(),
      };
  void toggleComplete(CartItems item) => {
        item.isCompleted = !item.isCompleted,
        toggleFood(item),
        notifyListeners(),
      };

  set foodList(List<Items> foodList) {
    foods = foodList;
    notifyListeners();
  }

  List<Items> getFoods() => foods;

  Items get currentFood => _currentFood;

  set currentFood(Items food) {
    _currentFood = food;
    notifyListeners();
  }

  addFood(Items food) {
    foods.insert(0, food);
    notifyListeners();
  }

  deleteFood(Items food) async {
    foods.removeWhere((_food) => _food.name == food.name);
    deleteFood(food);
    notifyListeners();
  }
}
