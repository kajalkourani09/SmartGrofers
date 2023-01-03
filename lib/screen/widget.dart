import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groceryapp/firebase/auth.dart';

import 'package:groceryapp/screen/declare.dart';
import 'package:groceryapp/screen/productdecreption.dart';

import 'package:groceryapp/screen/selectcategory.dart';
import 'package:provider/provider.dart';
import '../model/category.dart';
import '../model/utils.dart';
import '../providers/categoryselectionservice.dart';
import 'bottomnavigationbar.dart';
import 'homescreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:groceryapp/screen/register.dart';

Demo d1 = Demo();

class myTextFormField extends StatefulWidget {
  final TextEditingController mycontroller;
  final Icon myIcon;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const myTextFormField({
    Key? key,
    required this.mycontroller,
    required this.myIcon,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    required this.validator,
  }) : super(key: key);

  @override
  State<myTextFormField> createState() => _myTextFormFieldState();
}

class _myTextFormFieldState extends State<myTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 60,
        child: TextFormField(
          controller: widget.mycontroller,
          decoration: InputDecoration(
              prefixIcon: widget.myIcon,
              hintText: widget.hintText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: Colors.amber, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Colors.amber, width: 2)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(50))),
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
        ));
  }
}

class myprofile extends StatefulWidget {
  final String s1;
  final Icon i1;
  final Function onTap;
  const myprofile({
    required this.s1,
    required this.i1,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<myprofile> createState() => _myprofileState();
}

class _myprofileState extends State<myprofile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("clicked");
      },
      child: ListTile(
        leading: widget.i1,
        title: Text(widget.s1),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
      ),
    );
  }
}

class homeContainer extends StatelessWidget {
  const homeContainer({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category_item category;

  @override
  Widget build(BuildContext context) {
    CategorySelectionService catselection =
        Provider.of<CategorySelectionService>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: category.c1, width: 2),
          borderRadius: BorderRadius.circular(20),
          color: category.c2),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  catselection.selectedCategory = category;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SelectCategory(catselection.selectedCategory)));
                },
                child: Image.asset(category.image, height: 100))
          ],
        ),
        SizedBox(height: 5),
        Align(
          alignment: Alignment.center,
          child: Text(
            category.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ]),
    );
  }
}

class ListContainer1 extends StatefulWidget {
  const ListContainer1({
    Key? key,
  }) : super(key: key);

  @override
  State<ListContainer1> createState() => _ListContainer1State();
}

class _ListContainer1State extends State<ListContainer1> {
  List<Category_item> categories = Utils.getMockedcategories();

  @override
  Widget build(BuildContext context) {
    CategorySelectionService catselection =
        Provider.of<CategorySelectionService>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Container(
        height: 160,
        child: ListView.separated(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
                  width: 10,
                ),
            itemBuilder: (BuildContext context, int index) {
              Category_item category = categories[index];
              return Container(
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: categories[index].c2,
                    border: Border.all(width: 2, color: categories[index].c1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                      )
                    ]),
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          catselection.selectedCategory = category;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectCategory(
                                      catselection.selectedCategory)));
                        },
                        child: Image.asset(
                          category.image,
                          height: 100,
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      category.title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class ListContainer2 extends StatelessWidget {
  final Axis s1;

  List<Category_item> categories = Utils.getMockedcategories();

  ListContainer2({Key? key, required this.s1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Category_item categories;

    CategorySelectionService catselection =
        Provider.of<CategorySelectionService>(context, listen: false);
    // categories=catselection.selectedCategory.subcategory.length.;

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Container(
        height: 200,
        child: GridView.builder(
            scrollDirection: s1,
            itemCount: categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, mainAxisSpacing: 10),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  width: 190,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      border: Border.all(width: 2, color: categories[index].c1),
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
                          Image.asset(
                            categories[index].subcategory[index].image,
                            height: 100,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 27),
                        child: Text(
                          categories[index].subcategory[index].title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            // color: Colors.red,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            categories[index].subcategory[index].price,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                catselection.selectedProduct =
                                    categories[index].subcategory[index];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDecreption(
                                            catselection.selectProduct)));
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
            }),
      ),
    );
  }
}

class GoogleButton extends StatefulWidget {
  const GoogleButton({
    Key? key,
  }) : super(key: key);

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  Future<void> google_sign_in(context) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          final authresult = await auth.signInWithCredential(
              GoogleAuthProvider.credential(
                  idToken: googleAuth.idToken,
                  accessToken: googleAuth.accessToken));
          final uid = authresult.user!.uid;
          print(uid);

          if (authresult.additionalUserInfo!.isNewUser) {
            await FirebaseFirestore.instance.collection('users').doc(uid).set({
              'id': uid,
              'name': auth.currentUser!.displayName,
              'email': auth.currentUser!.email,
              'imageurl': auth.currentUser!.photoURL,
              'createdAt': Timestamp.now()
            });
          } else {
            print("already created $uid");
          }
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => BottomNavigation())));
        } on FirebaseException catch (error) {
          Fluttertoast.showToast(msg: error.code);
        } catch (error) {
          Fluttertoast.showToast(msg: error.toString());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        google_sign_in(context);
        print("clicked");
      },
      child: Container(
          width: MediaQuery.of(context).size.width - 60,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.grey),
              boxShadow: [BoxShadow(color: Colors.white)]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(d1.google),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Continue with Google",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
    );
  }
}

class cartWidget extends StatefulWidget {
  int index;

  cartWidget({super.key, required this.index});

  @override
  State<cartWidget> createState() => _cartWidgetState();
}

class _cartWidgetState extends State<cartWidget> {
  List<Category_item> categories = Utils.getMockedcategories();

  @override
  Widget build(BuildContext context) {
    // Category_item category= categories[widget.index].image;
    return Container(
      height: 100,
      color: Colors.grey.shade400,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              categories[widget.index].subcategory[widget.index].image,
              height: 70,
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Name:"),
                      Text(
                        categories[widget.index]
                            .subcategory[widget.index]
                            .title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text("Unit:"),
                      Text(
                        categories[widget.index]
                            .subcategory[widget.index]
                            .productSubCategory[widget.index]
                            .cartCategory[widget.index]
                            .unit,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text("Price:"),
                      Text(
                        categories[widget.index]
                            .subcategory[widget.index]
                            .productSubCategory[widget.index]
                            .cartCategory[widget.index]
                            .product_price
                            .toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13),
              child: Row(children: [
                Icon(Icons.remove),
                SizedBox(
                  width: 7,
                ),
                Text(
                  "0",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 7,
                ),
                Icon(Icons.add),
                SizedBox(
                  width: 18,
                ),
                GestureDetector(
                  onTap: (() => print("clicked")),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
