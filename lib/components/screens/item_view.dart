import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/model/cart.dart';
import 'package:groceryapp/model/data.dart';
import 'package:groceryapp/provider/cartProvider.dart';
import 'package:provider/provider.dart';

class ItemView extends StatefulWidget {
  final Items item;

  const ItemView({Key key, @required this.item}) : super(key: key);

  @override
  _ItemViewState createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Items item = widget.item;
    int price = int.parse(item.price) * count;
    final provider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          item.name,
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  transitionOnUserGestures: true,
                  tag: item,
                  child: Container(
                    child: Center(
                      child: Container(
                        height: width * 0.4,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(item.imageUrl),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Rs.${item.price}",
                    style: TextStyle(color: Colors.amber, fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: width * 0.15,
                    width: width * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          if (count <= 0) {
                            return;
                          } else {
                            setState(() {
                              count--;
                            });
                          }
                        },
                        child: Text(
                          "-",
                          style: TextStyle(fontSize: width * 0.1),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      count.toString(),
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: width * 0.15,
                    width: width * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          count++;
                        });
                      },
                      child: Center(
                        child: Text(
                          "+",
                          style: TextStyle(fontSize: width * 0.1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    count == 0 ? "" : "Amount : Rs.${price.toString()}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.06,
                        letterSpacing: 1.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        if (count > 0) {
                          provider
                              .addItem(CartItems(item: item, amount: price));
                          Navigator.pop(context);
                        } else {
                          Flushbar(
                            title: "Sorry",
                            message: "Empty Items",
                            duration: Duration(seconds: 2),
                            flushbarPosition: FlushbarPosition.TOP,
                            flushbarStyle: FlushbarStyle.FLOATING,
                            reverseAnimationCurve: Curves.decelerate,
                            forwardAnimationCurve: Curves.elasticOut,
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            icon: Icon(
                              Icons.warning,
                              color: Colors.amber,
                            ),
                            boxShadows: [
                              BoxShadow(
                                  color: Colors.grey[800],
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 5.0)
                            ],
                            leftBarIndicatorColor: Colors.red,
                          )..show(context);
                        }
                      },
                      child: Container(
                        height: width * 0.1,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                          child: Text("ADD TO LIST",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
