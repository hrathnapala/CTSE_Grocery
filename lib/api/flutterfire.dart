import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:groceryapp/model/cart.dart';
import 'package:groceryapp/model/data.dart';
import 'package:groceryapp/provider/cartProvider.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

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
  List<Items> _item = [];

  snapshot.documents.forEach((document) {
    Items item = Items.fromMap(document.data);
    _item.add(item);
  });

  cartProvider.foodList = _item;
}

uploadFoodAndImage(Items food, File localFile) async {
  if (localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();

    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('foods/images/$uuid$fileExtension');

    await firebaseStorageRef
        .putFile(localFile)
        .onComplete
        .catchError((onError) {
      print(onError);
      return false;
    });

    String url = await firebaseStorageRef.getDownloadURL();
    print("download url: $url");
    _uploadFood(food, imageUrl: url);
  } else {
    print('...skipping image upload');
    _uploadFood(food);
  }
}

_uploadFood(Items food, {String imageUrl}) async {
  CollectionReference foodRef = Firestore.instance.collection('Foods');

  if (imageUrl != null) {
    food.imageUrl = imageUrl;
  }

  DocumentReference documentRef = await foodRef.add(food.toMap());

  print('uploaded food successfully: ${food.toString()}');

  await documentRef.setData(food.toMap(), merge: true);
}

uploadList(CartItems food) async {
  CollectionReference foodRef = Firestore.instance.collection('Cart');

  DocumentReference documentRef = await foodRef.add(food.toMap());

  print('uploaded food successfully: ${food.toString()}');

  await documentRef.setData(food.toMap(), merge: true);
}

getCartItems(CartProvider cartProvider) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection('Cart').getDocuments();
  List<CartItems> _item = [];

  snapshot.documents.forEach((document) {
    CartItems item = CartItems.fromMap(document.data);
    _item.add(item);
  });

  cartProvider.setCart = _item;
}

deleteFood(CartItems item, CartProvider provider) async {
  Firestore.instance
      .collection("Cart")
      .where("id", isEqualTo: item.id)
      .getDocuments()
      .then((value) {
    value.documents.forEach((element) {
      Firestore.instance
          .collection("Cart")
          .document(element.documentID)
          .delete()
          .then((value) {
        provider.deleteItem(item);
      });
    });
  });
}

toggleFood(CartItems food) {
  Firestore.instance
      .collection("Cart")
      .where("id", isEqualTo: food.id)
      .getDocuments()
      .then((value) {
    value.documents.forEach((element) {
      Firestore.instance
          .collection("Cart")
          .document(element.documentID)
          .updateData(food.toMap())
          .then((value) {});
    });
  });
}
