import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:groceryapp/model/data.dart';
import 'package:groceryapp/provider/cartProvider.dart';
import 'package:path/path.dart' as path;
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
  CartProvider cartProvider;

  if (imageUrl != null) {
    food.imageUrl = imageUrl;
  }

  DocumentReference documentRef = await foodRef.add(food.toMap());

  print('uploaded food successfully: ${food.toString()}');

  await documentRef.setData(food.toMap(), merge: true);
}
