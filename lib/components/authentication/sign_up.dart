import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groceryapp/api/flutterfire.dart';
import 'package:groceryapp/pallete.dart';
import 'package:email_validator/email_validator.dart';
import 'package:another_flushbar/flushbar.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _email;
  TextEditingController _password;
  TextEditingController _confirmpassword;
  bool _notShowPassword = true;

  @override
  void initState() {
    super.initState();
    _email = new TextEditingController();
    _password = new TextEditingController();
    _confirmpassword = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _confirmpassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              constraints:
                  BoxConstraints(maxHeight: size.height, maxWidth: size.width),
              color: Color(0xFF030305),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 36.0, horizontal: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Register",
                              style: TextStyle(
                                  color: kWhite,
                                  fontSize: 46.0,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Happy Shopping",
                              style: TextStyle(
                                  color: kWhite,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                    flex: 5,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 5.0),
                          color: Color(0xFF061C56),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60.0),
                            topRight: Radius.circular(60.0),
                          )),
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextField(
                              controller: _email,
                              style: TextStyle(color: kWhite),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.greenAccent, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0),
                                ),
                                filled: true,
                                fillColor: Colors.black45,
                                hintStyle: TextStyle(color: kWhite),
                                hintText: "Enter Email",
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: kWhite,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextField(
                              controller: _password,
                              obscureText: _notShowPassword,
                              style: TextStyle(color: kWhite),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.black45,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.greenAccent, width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 2.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 2.0),
                                  ),
                                  hintText: "Enter Password",
                                  hintStyle: TextStyle(color: kWhite),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _notShowPassword = !_notShowPassword;
                                      });
                                    },
                                    child: Icon(
                                      _notShowPassword
                                          ? CupertinoIcons.eye_slash_fill
                                          : CupertinoIcons.eye_solid,
                                      color: kWhite,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: kWhite,
                                  )),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextField(
                              controller: _confirmpassword,
                              obscureText: _notShowPassword,
                              style: TextStyle(color: kWhite),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.black45,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.greenAccent, width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 2.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 2.0),
                                  ),
                                  hintText: "Enter Confirm Password",
                                  hintStyle: TextStyle(color: kWhite),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _notShowPassword = !_notShowPassword;
                                      });
                                    },
                                    child: Icon(
                                      _notShowPassword
                                          ? CupertinoIcons.eye_slash_fill
                                          : CupertinoIcons.eye_solid,
                                      color: kWhite,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: kWhite,
                                  )),
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.popAndPushNamed(
                                        context, "/SignIn");
                                  },
                                  child: Text(
                                    "Back to login page",
                                    style: TextStyle(
                                      color: kBlue,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                icon: FaIcon(
                                  FontAwesomeIcons.userPlus,
                                  color: kBlack,
                                ),
                                label: Text("Register"),
                                onPressed: () async {
                                  if (_email.text == "" ||
                                      _password.text == "" ||
                                      _confirmpassword.text == "") {
                                    Flushbar(
                                      title: "Sorry",
                                      message: "Fill the form correctly",
                                      duration: Duration(seconds: 3),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      flushbarStyle: FlushbarStyle.FLOATING,
                                      reverseAnimationCurve: Curves.decelerate,
                                      forwardAnimationCurve: Curves.elasticOut,
                                      backgroundColor: Colors.black,
                                      icon: Icon(
                                        Icons.warning,
                                        color: Colors.amber,
                                      ),
                                      showProgressIndicator: true,
                                      progressIndicatorBackgroundColor:
                                          Colors.black,
                                      boxShadows: [
                                        BoxShadow(
                                            color: Colors.grey[800],
                                            offset: Offset(0.0, 2.0),
                                            blurRadius: 5.0)
                                      ],
                                      leftBarIndicatorColor: Colors.red,
                                    )..show(context);
                                  } else if (_password.text.length < 6) {
                                    Flushbar(
                                      title: "Sorry",
                                      message:
                                          "Password should contain minimum 6 characters",
                                      duration: Duration(seconds: 3),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      flushbarStyle: FlushbarStyle.FLOATING,
                                      reverseAnimationCurve: Curves.decelerate,
                                      forwardAnimationCurve: Curves.elasticOut,
                                      backgroundColor: Colors.black,
                                      icon: Icon(
                                        Icons.warning,
                                        color: Colors.amber,
                                      ),
                                      showProgressIndicator: true,
                                      progressIndicatorBackgroundColor:
                                          Colors.black,
                                      boxShadows: [
                                        BoxShadow(
                                            color: Colors.grey[800],
                                            offset: Offset(0.0, 2.0),
                                            blurRadius: 5.0)
                                      ],
                                      leftBarIndicatorColor: Colors.red,
                                    )..show(context);
                                  } else if (_password.text !=
                                      _confirmpassword.text) {
                                    Flushbar(
                                      title: "Sorry",
                                      message: "Passwords are not matching",
                                      duration: Duration(seconds: 3),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      flushbarStyle: FlushbarStyle.FLOATING,
                                      reverseAnimationCurve: Curves.decelerate,
                                      forwardAnimationCurve: Curves.elasticOut,
                                      backgroundColor: Colors.black,
                                      icon: Icon(
                                        Icons.warning,
                                        color: Colors.amber,
                                      ),
                                      showProgressIndicator: true,
                                      progressIndicatorBackgroundColor:
                                          Colors.black,
                                      boxShadows: [
                                        BoxShadow(
                                            color: Colors.grey[800],
                                            offset: Offset(0.0, 2.0),
                                            blurRadius: 5.0)
                                      ],
                                      leftBarIndicatorColor: Colors.red,
                                    )..show(context);
                                  } else if (!EmailValidator.validate(
                                      _email.text)) {
                                    Flushbar(
                                      title: "Sorry",
                                      message: "Invalid Email",
                                      duration: Duration(seconds: 3),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      flushbarStyle: FlushbarStyle.FLOATING,
                                      reverseAnimationCurve: Curves.decelerate,
                                      forwardAnimationCurve: Curves.elasticOut,
                                      backgroundColor: Colors.black,
                                      icon: Icon(
                                        Icons.warning,
                                        color: Colors.amber,
                                      ),
                                      showProgressIndicator: true,
                                      progressIndicatorBackgroundColor:
                                          Colors.black,
                                      boxShadows: [
                                        BoxShadow(
                                            color: Colors.grey[800],
                                            offset: Offset(0.0, 2.0),
                                            blurRadius: 5.0)
                                      ],
                                      leftBarIndicatorColor: Colors.red,
                                    )..show(context);
                                  } else {
                                    bool signup = await register(
                                        _email.text, _password.text);

                                    if (signup) {
                                      Flushbar(
                                        title: "Successfully Registered",
                                        message: "Back to login page",
                                        duration: Duration(seconds: 1),
                                        flushbarPosition: FlushbarPosition.TOP,
                                        flushbarStyle: FlushbarStyle.FLOATING,
                                        reverseAnimationCurve:
                                            Curves.decelerate,
                                        forwardAnimationCurve:
                                            Curves.elasticOut,
                                        backgroundColor: Colors.black,
                                        icon: Icon(
                                          Icons.thumb_up_sharp,
                                          color: Colors.amber,
                                        ),
                                        showProgressIndicator: true,
                                        progressIndicatorBackgroundColor:
                                            Colors.black,
                                        boxShadows: [
                                          BoxShadow(
                                              color: Colors.grey[800],
                                              offset: Offset(0.0, 2.0),
                                              blurRadius: 5.0)
                                        ],
                                        leftBarIndicatorColor: Colors.red,
                                      )..show(context);
                                      Timer(
                                          Duration(seconds: 2),
                                          () => {
                                                Navigator.popAndPushNamed(
                                                    context, "/SignIn")
                                              });
                                    } else {
                                      Flushbar(
                                        title: "Sorry",
                                        message: "Register Failed",
                                        duration: Duration(seconds: 3),
                                        flushbarPosition: FlushbarPosition.TOP,
                                        flushbarStyle: FlushbarStyle.FLOATING,
                                        reverseAnimationCurve:
                                            Curves.decelerate,
                                        forwardAnimationCurve:
                                            Curves.elasticOut,
                                        backgroundColor: Colors.black,
                                        icon: Icon(
                                          Icons.warning,
                                          color: Colors.amber,
                                        ),
                                        showProgressIndicator: true,
                                        progressIndicatorBackgroundColor:
                                            Colors.black,
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
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey,
                                    onPrimary: Colors.white,
                                    onSurface: Colors.grey,
                                    shadowColor: kBlue,
                                    elevation: 5.0),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
