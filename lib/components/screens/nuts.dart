import 'package:flutter/material.dart';
import 'package:groceryapp/api/flutterfire.dart';
import 'package:groceryapp/components/screens/item_view.dart';
import 'package:groceryapp/provider/cartProvider.dart';
import 'package:provider/provider.dart';

class Nuts extends StatefulWidget {
  @override
  _NutsState createState() => _NutsState();
}

class _NutsState extends State<Nuts> {
  @override
  void initState() {
    super.initState();
    CartProvider foodNotifier =
        Provider.of<CartProvider>(context, listen: false);
    getFoods(foodNotifier);
    getCartItems(foodNotifier);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    CartProvider foodNotifier = Provider.of<CartProvider>(context);
    List nuts = foodNotifier
        .getFoods()
        .where((element) => element.type == "nuts")
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
            children: nuts
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
                                child: FittedBox(
                                  child: Text(
                                    item.name,
                                    style: TextStyle(
                                        fontSize: width * 0.05,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900),
                                  ),
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
