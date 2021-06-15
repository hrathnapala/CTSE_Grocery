import 'dart:io';

import 'package:flutter/material.dart';
import 'package:groceryapp/api/flutterfire.dart';
import 'package:groceryapp/components/authentication/sign_in.dart';
import 'package:groceryapp/model/data.dart';
import 'package:groceryapp/provider/cartProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _name = TextEditingController();
  final _price = TextEditingController();
  final _type = TextEditingController();

  Items _currentFood;
  String _imageUrl;
  File _imageFile;
  TextEditingController subingredientController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    CartProvider foodNotifier =
        Provider.of<CartProvider>(context, listen: false);

    if (foodNotifier.currentFood != null) {
      _currentFood = foodNotifier.currentFood;
    } else {
      _currentFood = Items();
    }
    _imageUrl = _currentFood.imageUrl;
  }

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _price.dispose();
    _type.dispose();
  }

  _showImage() {
    if (_imageFile == null && _imageUrl == null) {
      return Text(
        "image placeholder",
        style: TextStyle(color: Colors.white),
      );
    } else if (_imageFile != null) {
      print('showing image from local file');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            _imageFile,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.blue,
            child: Text(
              'Change Image',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    } else if (_imageUrl != null) {
      print('showing image from url');
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.network(
            _imageUrl,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.yellow,
            child: Text(
              'Change Image',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    }
  }

  _getLocalImage() async {
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 400);

    if (imageFile != null) {
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

  Widget _buildName() {
    return TextField(
      controller: _name,
      decoration: InputDecoration(
          fillColor: Colors.white30,
          filled: true,
          isCollapsed: true,
          hintText: 'Name',
          contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 5),
          hintStyle: TextStyle(color: Colors.white)),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20, color: Colors.white),
    );
  }

  Widget _buildPrice() {
    return TextField(
      controller: _price,
      decoration: InputDecoration(
          fillColor: Colors.white30,
          filled: true,
          isCollapsed: true,
          hintText: 'Price',
          contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 5),
          hintStyle: TextStyle(color: Colors.white)),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20, color: Colors.white),
    );
  }

  Widget _buildType() {
    return TextField(
      controller: _type,
      decoration: InputDecoration(
          fillColor: Colors.white30,
          filled: true,
          isCollapsed: true,
          contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 5),
          hintText: 'fruit/vegetable/nuts/dairy',
          hintStyle: TextStyle(color: Colors.white)),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20, color: Colors.white),
    );
  }

  _saveFood() {
    if (_name.text == "" || _price.text == "" || _type.text == "") {
      Flushbar(
        title: "Sorry",
        message: "Empty Fields",
        duration: Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.FLOATING,
        backgroundColor: Colors.black,
        icon: Icon(
          Icons.thumb_up_sharp,
          color: Colors.red,
        ),
        showProgressIndicator: true,
        progressIndicatorBackgroundColor: Colors.black,
        boxShadows: [
          BoxShadow(
              color: Colors.grey[800],
              offset: Offset(0.0, 2.0),
              blurRadius: 5.0)
        ],
        leftBarIndicatorColor: Colors.red,
      )..show(context);
    } else if (_type.text != "fruit" ||
        _type.text != "vegetable" ||
        _type.text != "nuts" ||
        _type.text != "dairy") {
      Flushbar(
        title: "Sorry",
        message: "Wrong food type ",
        duration: Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.FLOATING,
        backgroundColor: Colors.black,
        icon: Icon(
          Icons.thumb_up_sharp,
          color: Colors.red,
        ),
        showProgressIndicator: true,
        progressIndicatorBackgroundColor: Colors.black,
        boxShadows: [
          BoxShadow(
              color: Colors.grey[800],
              offset: Offset(0.0, 2.0),
              blurRadius: 5.0)
        ],
        leftBarIndicatorColor: Colors.red,
      )..show(context);
    } else if (_imageFile == null) {
      Flushbar(
        title: "Sorry",
        message: "Please choose an image",
        duration: Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.FLOATING,
        backgroundColor: Colors.black,
        icon: Icon(
          Icons.thumb_up_sharp,
          color: Colors.red,
        ),
        showProgressIndicator: true,
        progressIndicatorBackgroundColor: Colors.black,
        boxShadows: [
          BoxShadow(
              color: Colors.grey[800],
              offset: Offset(0.0, 2.0),
              blurRadius: 5.0)
        ],
        leftBarIndicatorColor: Colors.red,
      )..show(context);
    } else {
      try {
        uploadFoodAndImage(
            Items(name: "Apple", price: "800", type: "fruit"), _imageFile);
        setState(() {
          _imageFile = null;
        });
        Flushbar(
          title: "Success",
          message: "Uploading Success",
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.FLOATING,
          backgroundColor: Colors.black,
          icon: Icon(
            Icons.thumb_up_sharp,
            color: Colors.green,
          ),
          showProgressIndicator: true,
          progressIndicatorBackgroundColor: Colors.black,
          boxShadows: [
            BoxShadow(
                color: Colors.grey[800],
                offset: Offset(0.0, 2.0),
                blurRadius: 5.0)
          ],
          leftBarIndicatorColor: Colors.green,
        )..show(context);
      } catch (e) {
        Flushbar(
          title: "Failed",
          message: "Uploading Failed",
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.FLOATING,
          backgroundColor: Colors.black,
          icon: Icon(
            Icons.thumb_up_sharp,
            color: Colors.red,
          ),
          showProgressIndicator: true,
          progressIndicatorBackgroundColor: Colors.black,
          boxShadows: [
            BoxShadow(
                color: Colors.grey[800],
                offset: Offset(0.0, 2.0),
                blurRadius: 5.0)
          ],
          leftBarIndicatorColor: Colors.red,
        )..show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => SignIn()));
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Food Form',
          style: TextStyle(color: Colors.amber),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _showImage(),
                _imageFile == null && _imageUrl == null
                    ? ButtonTheme(
                        child: RaisedButton(
                          onPressed: () => _getLocalImage(),
                          child: Text(
                            'Add Image',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    : SizedBox(height: 0),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildName(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildPrice(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildType(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _saveFood();
        },
        child: Icon(Icons.save),
        foregroundColor: Colors.black,
      ),
    );
  }
}
