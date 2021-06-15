import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groceryapp/components/screens.dart';
import 'package:groceryapp/pallete.dart';
import 'package:groceryapp/provider/cartProvider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (create) => CartProvider(),
      child: MaterialApp(
        title: 'Grocery Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: kBlack,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/Home': (context) => Home(),
          '/SignIn': (context) => SignIn(),
          '/SignUp': (context) => SignUp(),
          '/GoogleSignInMiddleScreen': (context) => GoogleSignInMiddleScreen(),
        },
      ),
    );
  }
}
