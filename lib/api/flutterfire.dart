import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceryapp/model/data.dart';
import 'package:groceryapp/provider/cartProvider.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

getFoods(CartProvider cartProvider) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection('Foods').getDocuments();
  // .orderBy("createdAt", descending: true)

  List<Items> _item = [];

  snapshot.documents.forEach((document) {
    Items item = Items.fromMap(document.data);
    _item.add(item);
  });

  cartProvider.foodList = _item;
}
