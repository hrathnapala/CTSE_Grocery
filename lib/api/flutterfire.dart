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
  // .orderBy("createdAt", descending: true)

  List<Items> _item = [];

  snapshot.documents.forEach((document) {
    Items item = Items.fromMap(document.data);
    _item.add(item);
  });

  cartProvider.foodList = _item;
}

uploadFoodAndImage(
    Items food, bool isUpdating, File localFile, Function foodUploaded) async {
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
    _uploadFood(food, isUpdating, foodUploaded, imageUrl: url);
  } else {
    print('...skipping image upload');
    _uploadFood(food, isUpdating, foodUploaded);
  }
}

_uploadFood(Items food, bool isUpdating, Function foodUploaded,
    {String imageUrl}) async {
  CollectionReference foodRef = Firestore.instance.collection('Foods');

  if (imageUrl != null) {
    food.imageUrl = imageUrl;
  }

  if (isUpdating) {
    // food.updatedAt = Timestamp.now();

    // await foodRef.document(food.id).updateData(food.toMap());

    foodUploaded(food);
    // print('updated food with id: ${food.id}');
  } else {
    // food.createdAt = Timestamp.now();

    DocumentReference documentRef = await foodRef.add(food.toMap());

    // food.id = documentRef.documentID;

    print('uploaded food successfully: ${food.toString()}');

    await documentRef.setData(food.toMap(), merge: true);

    foodUploaded(food);
  }
}
