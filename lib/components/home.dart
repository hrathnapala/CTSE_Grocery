import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/components/screens.dart';
import 'package:groceryapp/components/screens/cart.dart';
import 'package:groceryapp/provider/cartProvider.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;
  bool mode = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<CartProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text(
              "Grocery List",
              style: TextStyle(color: Colors.amber),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/SignIn");
                }),
            actions: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(8)),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Cart()));
                      },
                      child: Center(
                        child: Text(provider.getItems().length == 0
                            ? "0"
                            : provider.getItems().length.toString()),
                      ),
                    )),
              )
            ],
          ),
          body: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBar(
                      indicatorColor: Colors.blueGrey,
                      indicatorWeight: 3.0,
                      labelColor: Colors.orange,
                      unselectedLabelColor: Colors.yellow[100],
                      isScrollable: true,
                      controller: tabController,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        Tab(
                          child: Text(
                            "Fruits",
                            style: TextStyle(fontSize: size.width * 0.05),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Vegetables",
                            style: TextStyle(fontSize: size.width * 0.05),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Nuts & Seeds",
                            style: TextStyle(fontSize: size.width * 0.05),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Dairy",
                            style: TextStyle(fontSize: size.width * 0.05),
                          ),
                        )
                      ]),
                ),
                Expanded(
                    child: Container(
                  child: TabBarView(controller: tabController, children: [
                    Fruits(),
                    Vegetables(),
                    Nuts(),
                    Dairy(),
                  ]),
                )),
              ],
            ),
          )),
    );
  }
}
