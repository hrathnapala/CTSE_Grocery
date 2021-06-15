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

  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();

  List listItem = [
    "fruit",
    "vegetable",
    "nuts",
    "dairy",
  ];

  String valueChoose;

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
  }

  _showImage() {
    if (_imageFile == null) {
      return Text(
        "image placeholder",
        style: TextStyle(color: Colors.white),
      );
    } else if (_imageFile != null) {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            _imageFile,
            fit: BoxFit.cover,
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0)),
            child: FlatButton(
              padding: EdgeInsets.all(16),
              color: Colors.black,
              child: Text(
                'Change Image',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () => _getLocalImage(),
            ),
          )
        ],
      );
    }
  }

  _getLocalImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Widget _buildName() {
    return TextField(
      controller: _name,
      autofocus: false,
      decoration: InputDecoration(
          fillColor: Colors.white30,
          filled: true,
          isCollapsed: true,
          hintText: 'Name',
          contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
          hintStyle: TextStyle(color: Colors.white)),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildPrice() {
    return TextField(
      controller: _price,
      autofocus: false,
      decoration: InputDecoration(
          fillColor: Colors.white30,
          filled: true,
          isCollapsed: true,
          hintText: 'Price',
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          hintStyle: TextStyle(color: Colors.white)),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildType() {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15.0)),
      child: DropdownButton(
        hint: Text(
          "Select Food Type",
          style: TextStyle(color: Colors.white),
        ),
        underline: SizedBox(),
        value: valueChoose,
        dropdownColor: Colors.grey[300],
        icon: Icon(Icons.arrow_drop_down),
        iconSize: width * 0.05,
        isExpanded: true,
        style: TextStyle(fontSize: width * 0.04, color: Colors.blue),
        onChanged: (newValue) {
          setState(() {
            valueChoose = newValue;
          });
        },
        items: listItem.map((valueItem) {
          return DropdownMenuItem(
            value: valueItem,
            child: Text(
              valueItem,
              style: TextStyle(color: Colors.blue),
            ),
          );
        }).toList(),
      ),
    );
  }

  _saveFood() {
    if (_name.text == "" || _price.text == "") {
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
    } else if (valueChoose == "" || valueChoose == null) {
      Flushbar(
        title: "Sorry",
        message: "Please choose an item type from the dropdown",
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
            Items(name: _name.text, price: _price.text, type: valueChoose),
            _imageFile);
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
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
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
            'Item Form',
            style: TextStyle(color: Colors.amber),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _imageFile == null
                            ? Text(
                                "image placeholder",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5),
                              )
                            : Container(
                                height: width * 0.3,
                                width: width * 0.3,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.file(
                                    _imageFile,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              _getLocalImage();
                            },
                            child: Container(
                              height: width * 0.10,
                              width: width * 0.5,
                              decoration: BoxDecoration(
                                // color: Colors.blue.withOpacity(0.4),

                                border:
                                    Border.all(color: Colors.blue, width: 3.0),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Center(
                                child: FittedBox(
                                  child: Text(
                                    _imageFile == null
                                        ? "Add Image"
                                        : "Change Image",
                                    style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
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
                // Expanded(
                //   flex: 1,
                //   child: InkWell(
                //     onTap: () {
                //       _saveFood();
                //     },
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Container(
                //         width: double.infinity,
                //         child: Center(
                //           child: Container(
                //             // width: width * 0.5,
                //             height: width * 0.15,
                //             decoration: BoxDecoration(
                //                 color: Colors.amber,
                //                 borderRadius: BorderRadius.circular(10.0)),
                //             child: Center(
                //               child: Text(
                //                 "Save Data",
                //                 style: TextStyle(
                //                     color: Colors.black,
                //                     fontSize: width * 0.05),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        // body: GestureDetector(
        //   onTap: () {
        //     FocusScope.of(context).requestFocus(new FocusNode());
        //   },
        //   child: SafeArea(
        //     child: SingleChildScrollView(
        //       child: ConstrainedBox(
        //         constraints: BoxConstraints(
        //             maxHeight: MediaQuery.of(context).size.height -
        //                 MediaQuery.of(context).size.width * 0.2),
        //         child: Column(children: [
        //           Expanded(
        //             flex: 1,
        //             child: Container(
        //               width: double.infinity,
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 children: [
        //                   _showImage(),
        //                   _imageFile == null && _imageUrl == null
        //                       ? ButtonTheme(
        //                           child: RaisedButton(
        //                             onPressed: () => _getLocalImage(),
        //                             child: Text(
        //                               'Add Image',
        //                               style: TextStyle(color: Colors.white),
        //                             ),
        //                           ),
        //                         )
        //                       : SizedBox(height: 0),
        //                 ],
        //               ),
        //             ),
        //           ),
        //           Expanded(
        //             flex: 1,
        //             child: Container(
        //               child: Padding(
        //                 padding: const EdgeInsets.all(16.0),
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   crossAxisAlignment: CrossAxisAlignment.center,
        //                   children: [
        //                     Padding(
        //                       padding: const EdgeInsets.all(8.0),
        //                       child: _buildName(),
        //                     ),
        //                     Padding(
        //                       padding: const EdgeInsets.all(8.0),
        //                       child: _buildPrice(),
        //                     ),
        //                     Padding(
        //                       padding: const EdgeInsets.all(8.0),
        //                       child: _buildType(),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ]),
        //       ),
        //     ),
        //   ),
        // ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            _saveFood();
          },
          child: Icon(Icons.save),
          foregroundColor: Colors.black,
        ),
      ),
    );
  }
}
