import 'package:flutter/material.dart';
import 'package:groceryapp/model/category.dart';
import 'package:groceryapp/screen/declare.dart';
import 'package:groceryapp/model/utils.dart';
import 'package:groceryapp/screen/homescreen.dart';
import 'package:groceryapp/screen/widget.dart';

import 'bottomnavigationbar.dart';

class categoryScreen extends StatelessWidget {
  Demo d1 = Demo();
  List<Category_item> categories = Utils.getMockedcategories();

  categoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.amber,
      //   title: Text("Category"),
      //   centerTitle: true,
        
      // ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Container(child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavigation()));
                    },
                    child: Icon(Icons.arrow_back_ios)),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Categories",style: TextStyle(
                    fontSize: 30,
                    
                  ),),
                ],
              )),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: GridView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    childAspectRatio: screenWidth / 360,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    Category_item category = categories[index];
      
                    return homeContainer(category: categories[index]);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
