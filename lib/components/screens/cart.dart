import 'package:flutter/material.dart';
import 'package:groceryapp/model/cart.dart';
import 'package:groceryapp/provider/cartProvider.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context);
    List<CartItems> cart = provider.getItems();
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      // bottomNavigationBar: Container(
      //   height: width * 0.15,
      //   width: double.infinity,
      //   color: Colors.white,
      //   child: Center(
      //     child: Text(provider.getAmount().toString()),
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "List",
          style: TextStyle(color: Colors.amber),
        ),
        centerTitle: true,
      ),
      body: provider.getItems().length == 0
          ? Center(
              child: Text("No Items in  the cart",
                  style: TextStyle(
                    color: Colors.white,
                  )),
            )
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, count) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      provider.toggleComplete(cart[count]);
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: cart[count].isCompleted
                            ? Colors.red.withOpacity(0.5)
                            : Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      height: width * 0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: double.infinity,
                            width: width * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image:
                                      NetworkImage(cart[count].item.imageUrl)),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${cart[count].item.name}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.05,
                                    decoration: cart[count].isCompleted
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none),
                              ),
                              Text("Rs.${cart[count].amount.toString()}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.035,
                                      decoration: cart[count].isCompleted
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none)),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(
                              onTap: () {
                                provider.deleteItem(cart[count]);
                              },
                              child: Center(
                                child: Icon(
                                  Icons.cancel,
                                  size: width * 0.09,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
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
