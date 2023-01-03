import 'package:flutter/material.dart';
import 'package:groceryapp/model/cartitem.dart';
import 'package:groceryapp/model/category.dart';
import 'package:groceryapp/providers/cartservice.dart';
import 'package:provider/provider.dart';
import '../model/utils.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Text("hello");
  }

  @override
  Widget build(BuildContext context) {
    CartService c2 = Provider.of<CartService>(context, listen: false);
    List<Category_item> categories = Utils.getMockedcategories();
    return Scaffold(
        body: SafeArea(
            child: ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: categories.length,
      itemBuilder: ((context, index) =>
          Consumer<CartService>(builder: (context, c2, child) {
            // List<Widget> cartitems=[];
            List<CartItem> c1 = c2.items;
            Product p1 = c1[index].category;

            if (c2.items.isEmpty) {
              print("is empty");
              return Text("is empty");
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    color: Colors.amber,
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                p1.image,
                                height: 50,
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("name:"),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(p1.title),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("price:"),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(p1.price),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          })),
      separatorBuilder: (context, index) => SizedBox(
        height: 2,
      ),
    )));
  }
}
