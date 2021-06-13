import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/pallete.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4),
        () => Navigator.pushReplacementNamed(context, "/SignIn"));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart,
              color: kBlue,
              size: size.width * 0.3,
            ),
            Text(
              "Happy Shopping",
              style: TextStyle(color: kWhite, fontSize: size.width * 0.06),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            SpinKitChasingDots(
              color: kAmber,
              size: size.width * 0.08,
            )
          ],
        ),
      ),
    ));
  }
}
