import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:groceryapp/pallete.dart';

class GoogleSignInMiddleScreen extends StatefulWidget {
  @override
  _GoogleSignInMiddleScreenState createState() =>
      _GoogleSignInMiddleScreenState();
}

class _GoogleSignInMiddleScreenState extends State<GoogleSignInMiddleScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    final user = _googleSignIn.currentUser;

    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                  color: kWhite, fontWeight: FontWeight.w900, fontSize: 30.0),
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
            Text(
              "Name: " + user.displayName,
              style: TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.w900,
                  fontSize: size.width * 0.05),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              "Email: " + user.email,
              style: TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.w900,
                  fontSize: size.width * 0.05),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Text(
              "Proceed If Details are correct",
              style: TextStyle(
                  color: kBlue,
                  fontWeight: FontWeight.w900,
                  fontSize: size.width * 0.04),
            ),
            SizedBox(
              height: size.height * 0.01,
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
                  Navigator.pushReplacementNamed(context, "/Home");
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
              height: size.height * 0.03,
            ),
            Text(
              "If Not, Navigate back to login page",
              style: TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.w900,
                  fontSize: size.width * 0.04),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              width: size.width * 0.6,
              child: ElevatedButton.icon(
                icon: FaIcon(
                  FontAwesomeIcons.backward,
                  color: kRed,
                ),
                label: Text(
                  "Exit",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                onPressed: () {},
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
    );
  }
}
