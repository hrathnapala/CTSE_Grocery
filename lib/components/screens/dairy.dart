import 'package:flutter/material.dart';
import 'package:groceryapp/api/flutterfire.dart';
import 'package:groceryapp/components/screens/item_view.dart';
import 'package:groceryapp/model/data.dart';
import 'package:groceryapp/provider/cartProvider.dart';
import 'package:provider/provider.dart';

class Dairy extends StatefulWidget {
  @override
  _DairyState createState() => _DairyState();
}

class _DairyState extends State<Dairy> {
  final List<Items> _listItem = [
    Items(imageUrl: 'assets/images/milk.png', name: "Milk", price: "80"),
    Items(imageUrl: 'assets/images/butter.png', name: "Butter", price: "100"),
    Items(imageUrl: 'assets/images/cheese.png', name: "Cheese", price: "180"),
    Items(imageUrl: 'assets/images/Yoghurt.png', name: "Yoghurt", price: "100"),
    Items(
        imageUrl: 'assets/images/icecream.png', name: "Icecream", price: "120"),
    Items(
        imageUrl: 'assets/images/heavycream.png',
        name: "Heavycream",
        price: "100"),
  ];

  @override
  void initState() {
    super.initState();
    CartProvider foodNotifier =
        Provider.of<CartProvider>(context, listen: false);
    getFoods(foodNotifier);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    CartProvider foodNotifier = Provider.of<CartProvider>(context);
    List dairy = foodNotifier
        .getFoods()
        .where((element) => element.type == "dairy")
        .toList();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          Expanded(
              child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: dairy
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
                                    image: NetworkImage(item.imageUrl),
                                    fit: BoxFit.cover)),
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      colors: [
                                        Colors.black.withOpacity(.8),
                                        Colors.black.withOpacity(.2),
                                      ])),
                              child: FittedBox(
                                child: Text(
                                  item.name,
                                  style: TextStyle(
                                      fontSize: width * 0.05,
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
