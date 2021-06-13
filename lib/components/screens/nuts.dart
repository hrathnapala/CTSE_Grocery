import 'package:flutter/material.dart';
import 'package:groceryapp/components/screens/item_view.dart';
import 'package:groceryapp/model/data.dart';

class Nuts extends StatefulWidget {
  @override
  _NutsState createState() => _NutsState();
}

class _NutsState extends State<Nuts> {
  final List<Items> _listItem = [
    Items(imageUrl: 'assets/images/almond.png', name: "Almond", price: "80"),
    Items(
        imageUrl: 'assets/images/pistachios.png',
        name: "pistachios",
        price: "100"),
    Items(imageUrl: 'assets/images/walnut.png', name: "Walnut", price: "180"),
    Items(imageUrl: 'assets/images/cashew.png', name: "Cashew", price: "100"),
    Items(imageUrl: 'assets/images/pecans.png', name: "Pecans", price: "120"),
    Items(
        imageUrl: 'assets/images/hazelnut.png', name: "Hazelnut", price: "100"),
    Items(imageUrl: 'assets/images/peanut.png', name: "Peanut", price: "140"),
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
                                    image: AssetImage(item.imageUrl),
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
