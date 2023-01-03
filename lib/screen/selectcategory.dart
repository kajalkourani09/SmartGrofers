import 'package:flutter/material.dart';
import 'package:groceryapp/model/category.dart';
import 'package:groceryapp/screen/productdecreption.dart';

import 'package:provider/provider.dart';

import '../providers/categoryselectionservice.dart';

class SelectCategory extends StatefulWidget {
  Category_item c1;
  SelectCategory(this.c1);
  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: searchController.text.length));
    Category_item c1;
    var screenWidth = MediaQuery.of(context).size.width;
    CategorySelectionService catselection =
        Provider.of<CategorySelectionService>(context, listen: false);
    c1 = catselection.selectedCategory;
    // List<Product> p1=[];
    // void searchBook(String value) {
    //   setState(() {
    //      p1 = c1.subcategory.where((element) =>
    //         element.title.toLowerCase().contains(value.toLowerCase())).toList();
    //     print(p1);
    //   });
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.c1.title),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 20, top: 20),
          child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: screenWidth / 470,
              children: List.generate(widget.c1.subcategory.length,
                  // searchController.text.isEmpty
                  //     ? widget.c1.subcategory.length
                  //     : p1.length,
                  ((index) {
                return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        border:
                            Border.all(width: 2, color: Colors.grey.shade400),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image.asset(
                            //     searchController.text.isEmpty
                            //         ? widget.c1.subcategory[index].image
                            //         : p1[index].image,
                            //     height: 100),
                            Image.asset(
                              widget.c1.subcategory[index].image,
                              height: 100,
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 27),
                          // child: Text(
                          //   searchController.text.isNotEmpty
                          //       ? widget.c1.subcategory[index].title
                          //       : p1[index].title,
                          child: Text(
                            widget.c1.subcategory[index].title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              // color: Colors.red,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Text(
                            //   searchController.text.isEmpty
                            //       ? widget.c1.subcategory[index].price
                            //       : p1[index].price,
                            Text(
                              widget.c1.subcategory[index].price,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  catselection.selectedProduct =
                                      widget.c1.subcategory[index];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDecreption(catselection
                                                  .selectedProduct)));
                                },
                                child: Icon(
                                  Icons.add_circle_rounded,
                                  color: Colors.amber,
                                  size: 40,
                                ))
                          ],
                        ),
                      ],
                    ));
              }))),
        )
      ])),
    );
  }
}
