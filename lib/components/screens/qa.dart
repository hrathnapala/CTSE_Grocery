import 'package:flutter/material.dart';
import 'package:groceryapp/api/flutterfire.dart';
import 'package:groceryapp/model/cart.dart';
import 'package:groceryapp/provider/cartProvider.dart';
import 'package:provider/provider.dart';

class QA extends StatefulWidget {
  const QA({Key key}) : super(key: key);

  @override
  _QAState createState() => _QAState();
}

class _QAState extends State<QA> {
  @override
  Widget build(BuildContext context) {
    var questions = [
      "How Can I add Items to List?",
      "How Can I Delete Items from List?",
      "Who Manage Prices?",
      "Who Add Items to the APP?",
      "Is This APP Free?",
    ];
    var answers = [
      "You can click on the Add to List button.",
      "You can click on the Cross visible in list.",
      "An admin is responsible in managing prices",
      "An admin is responsible in adding Items",
      "This app is free",
    ];
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Q & A",
          style: TextStyle(color: Colors.amber),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, count) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: width * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${questions[count]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.05,
                            )),
                        Text("${answers[count]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.035,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
