import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:groceryapp/api/flutterfire.dart';
import 'package:groceryapp/components/screens/admin_screen.dart';
import 'package:groceryapp/pallete.dart';
import 'package:email_validator/email_validator.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:groceryapp/components/screens/qa.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _email;
  TextEditingController _password;
  bool _notShowPassword = true;

  bool _isLoggedIn = false;
  GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    _email = new TextEditingController();
    _password = new TextEditingController();
    _googleSignIn.signOut();
    setState(() {
      _userObj = null;
      _isLoggedIn = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = _googleSignIn.currentUser;
    return _isLoggedIn
        ? Scaffold(
            body: Container(
              alignment: Alignment.center,
              color: kBlack,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Profile",
                    style: TextStyle(
                        color: kWhite,
                        fontWeight: FontWeight.w900,
                        fontSize: 30.0),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  CircleAvatar(
                    radius: size.width * 0.1,
                    backgroundImage: NetworkImage(user.photoUrl),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  FittedBox(
                    child: Text(
                      "Name: " + user.displayName,
                      style: TextStyle(
                          color: kWhite,
                          fontWeight: FontWeight.w900,
                          fontSize: size.width * 0.05),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  FittedBox(
                    child: Text(
                      "Email: " + user.email,
                      style: TextStyle(
                          color: kWhite,
                          fontWeight: FontWeight.w900,
                          fontSize: size.width * 0.05),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Text(
                    "Proceed If Details are correct",
                    style: TextStyle(
                        color: kBlue,
                        fontWeight: FontWeight.w900,
                        fontSize: size.width * 0.04),
                  ),
                  Container(
                    width: size.width * 0.6,
                    child: ElevatedButton.icon(
                      icon: FaIcon(
                        FontAwesomeIcons.home,
                        color: kRed,
                      ),
                      label: Text(
                        "Proceed",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      onPressed: () {
                        Flushbar(
                          title: "Success",
                          message: "Everything OK",
                          duration: Duration(seconds: 1),
                          flushbarPosition: FlushbarPosition.TOP,
                          flushbarStyle: FlushbarStyle.FLOATING,
                          reverseAnimationCurve: Curves.decelerate,
                          forwardAnimationCurve: Curves.elasticOut,
                          backgroundColor: Colors.black,
                          icon: Icon(
                            Icons.thumb_up_sharp,
                            color: Colors.amber,
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
                        Timer(
                            Duration(seconds: 2),
                            () =>
                                {Navigator.popAndPushNamed(context, "/Home")});
                      },
                      style: ElevatedButton.styleFrom(
                          primary: kWhite,
                          onPrimary: kBlack,
                          onSurface: kBlack,
                          shadowColor: kRed,
                          elevation: 5.0),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  Text(
                    "If Not, Navigate back to login page",
                    style: TextStyle(
                        color: kWhite,
                        fontWeight: FontWeight.w900,
                        fontSize: size.width * 0.04),
                  ),
                  Container(
                    width: size.width * 0.6,
                    child: ElevatedButton.icon(
                      icon: FaIcon(
                        FontAwesomeIcons.arrowLeft,
                        color: kRed,
                      ),
                      label: Text(
                        "Exit",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      onPressed: () {
                        Flushbar(
                          title: "Exited",
                          message: "Have a Nice Day",
                          duration: Duration(seconds: 1),
                          flushbarPosition: FlushbarPosition.TOP,
                          flushbarStyle: FlushbarStyle.FLOATING,
                          reverseAnimationCurve: Curves.decelerate,
                          forwardAnimationCurve: Curves.elasticOut,
                          backgroundColor: Colors.black,
                          icon: Icon(
                            Icons.thumb_up_sharp,
                            color: Colors.amber,
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
                        Timer(
                            Duration(seconds: 2),
                            () => {
                                  Navigator.popAndPushNamed(context, "/SignIn")
                                });
                      },
                      style: ElevatedButton.styleFrom(
                          primary: kWhite,
                          onPrimary: kBlack,
                          onSurface: kBlack,
                          shadowColor: kRed,
                          elevation: 5.0),
                    ),
                  )
                ],
              ),
            ),
          )
        : SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: Container(
                    color: Color(0xFF030305),
                    constraints: BoxConstraints(
                        maxHeight: size.height, maxWidth: size.width),
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
                                    "Login",
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.greenAccent,
                                            width: 2.0),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.black45,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.greenAccent,
                                              width: 2.0),
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
                                              _notShowPassword =
                                                  !_notShowPassword;
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
                                              context, "/SignUp");
                                        },
                                        child: Text(
                                          "Create a new account",
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
                                        FontAwesomeIcons.home,
                                        color: kBlack,
                                      ),
                                      label: Text("Login"),
                                      onPressed: () async {
                                        if (_email.text == "" ||
                                            _password.text == "") {
                                          Flushbar(
                                            title: "Sorry",
                                            message: "Fill the form correctly",
                                            duration: Duration(seconds: 3),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            flushbarStyle:
                                                FlushbarStyle.FLOATING,
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
                                        } else if (_email.text ==
                                                "admin@gmail.com" &&
                                            _password.text == "admin") {
                                          Flushbar(
                                            title: "Success",
                                            message: "Login Success",
                                            duration: Duration(seconds: 1),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            flushbarStyle:
                                                FlushbarStyle.FLOATING,
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
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AdminScreen()))
                                                  });
                                        } else if (_password.text.length < 6) {
                                          Flushbar(
                                            title: "Sorry",
                                            message:
                                                "Password should contain 6 characters",
                                            duration: Duration(seconds: 3),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            flushbarStyle:
                                                FlushbarStyle.FLOATING,
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
                                        } else if (!EmailValidator.validate(
                                            _email.text)) {
                                          Flushbar(
                                            title: "Sorry",
                                            message: "Invalid Email",
                                            duration: Duration(seconds: 3),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            flushbarStyle:
                                                FlushbarStyle.FLOATING,
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
                                        } else {
                                          bool login = await signIn(
                                              _email.text, _password.text);

                                          if (login) {
                                            Flushbar(
                                              title: "Success",
                                              message: "Login Success",
                                              duration: Duration(seconds: 1),
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              flushbarStyle:
                                                  FlushbarStyle.FLOATING,
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
                                                          context, "/Home")
                                                    });
                                          } else {
                                            Flushbar(
                                              title: "Sorry",
                                              message: "Login Failed",
                                              duration: Duration(seconds: 3),
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              flushbarStyle:
                                                  FlushbarStyle.FLOATING,
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
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: 16.0),
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      icon: FaIcon(
                                        FontAwesomeIcons.google,
                                        color: kRed,
                                      ),
                                      label: Text(
                                        "Sign Up with Google",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900),
                                      ),
                                      onPressed: () {
                                        _googleSignIn.signIn().then((userData) {
                                          setState(() {
                                            _isLoggedIn = true;
                                            _userObj = userData;
                                          });
                                        }).catchError((e) {
                                          print(e);
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: kWhite,
                                          onPrimary: kBlack,
                                          onSurface: kBlack,
                                          shadowColor: kRed,
                                          elevation: 5.0),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => QA()));
                                        },
                                        child: Text(
                                          "Help / Contact Us",
                                          style: TextStyle(
                                            color: kBlue,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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
