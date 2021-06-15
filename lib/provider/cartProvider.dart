import 'package:flutter/cupertino.dart';
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
  void deleteItem(CartItems item) => {
        _items.remove(item),
        notifyListeners(),
      };
  void clearItem() => {
        _items = [],
        notifyListeners(),
      };
  void toggleComplete(CartItems item) => {
        item.isCompleted = !item.isCompleted,
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

  deleteFood(Items food) {
    foods.removeWhere((_food) => _food.name == food.name);
    notifyListeners();
  }
}
