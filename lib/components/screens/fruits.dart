import 'package:flutter/material.dart';
import 'package:groceryapp/components/screens/item_view.dart';
import 'package:groceryapp/model/data.dart';

class Fruits extends StatefulWidget {
  @override
  _FruitsState createState() => _FruitsState();
}

class _FruitsState extends State<Fruits> {
  List<Items> dataList = [];

  @override
  void initState() {
    super.initState();
  }

  final List<Items> _listItem = [
    Items(imageUrl: 'assets/images/apple.png', name: "Apple", price: "80"),
    Items(imageUrl: 'assets/images/avacado.png', name: "Avacado", price: "100"),
    Items(imageUrl: 'assets/images/grape.png', name: "Grape", price: "180"),
    Items(imageUrl: 'assets/images/banana.png', name: "Banana", price: "100"),
    Items(imageUrl: 'assets/images/orange.png', name: "Orange", price: "120"),
    Items(
        imageUrl: 'assets/images/watermelon.png',
        name: "Watermelon",
        price: "100"),
    Items(imageUrl: 'assets/images/papaya.png', name: "Papaya", price: "140"),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          Expanded(
              child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: _listItem
                .map((item) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemView(
                                      item: item,
                                    )));
                      },
                      child: Hero(
                        tag: item,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: ExactAssetImage(item.imageUrl),
                                    fit: BoxFit.cover)),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      colors: [
                                        Colors.black.withOpacity(.8),
                                        Colors.black.withOpacity(.2),
                                      ])),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  item.name,
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            )),
                      ),
                    ))
                .toList(),
          )),
        ],
      ),
    );
  }
}
