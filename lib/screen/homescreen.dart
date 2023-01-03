import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:groceryapp/firebase/auth.dart';
import 'package:groceryapp/providers/categoryselectionservice.dart';
import 'package:groceryapp/screen/categoryscreen.dart';
import 'package:groceryapp/screen/declare.dart';
import 'package:groceryapp/screen/login.dart';
import 'package:groceryapp/screen/profilescreen.dart';
import 'package:groceryapp/screen/widget.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../model/category.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  List<Product> subcategory = [];

  Demo d1 = Demo();
  String photo = "";
  String name = "";
  String email = "";
  String password = "";
  String id = "";
  int activeIndex = 0;
  int index = 0;
  int selected = 0;
  List<String> s1 = [
    "assets/images/home_image.jpg",
    "assets/images/home_image1.jpg",
    "assets/images/home_image2.jpg",
    "assets/images/home_image3.jpg",
  ];
  void changeSelected(int index) {
    setState(() {
      selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    CategorySelectionService catselection =
        Provider.of<CategorySelectionService>(context, listen: false);
    final screens = [HomeScreen(), categoryScreen(), ProfileScreen()];
    int currentIndex = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                        height: 70,
                        width: 70,
                        child: ClipOval(
                            child: Image.network(
                          photo,
                          fit: BoxFit.cover,
                        )))
                  ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(email),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(name),
                ],
              ),
            ),
            ListTile(
                selected: selected == 0,
                leading: const Icon(Icons.person),
                title: const Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  changeSelected(0);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                }),
            ListTile(
                selected: selected == 1,
                leading: const Icon(Icons.shopping_bag_outlined),
                title: const Text(
                  "Orders",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                onTap: (() => changeSelected(1))),
            ListTile(
                selected: selected == 2,
                leading: const Icon(Icons.info_outline),
                title: const Text(
                  "About",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                onTap: (() => changeSelected(2))),
            ListTile(
              selected: selected == 3,
              leading: const Icon(Icons.help_outline),
              title: const Text(
                "Help",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () {
                changeSelected(3);
              },
            ),
            ListTile(
                selected: selected == 4,
                leading: const Icon(Icons.logout_rounded),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  changeSelected(4);
                  signout();
                })
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: CarouselSlider.builder(
                itemCount: s1.length,
                options: CarouselOptions(
                    height: 300,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.9,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(() {
                        // print(reason.toString());//print the reason either auto or manual
                        activeIndex = index;
                      });
                    }),
                itemBuilder: (context, index, realIndex) {
                  final image = s1[index];
                  return Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: s1.length,
              effect: CustomizableEffect(
                  dotDecoration: const DotDecoration(
                    color: Colors.black54,
                    width: 10,
                    height: 10,
                  ),
                  activeDotDecoration: DotDecoration(
                    borderRadius: BorderRadius.circular(100),
                    width: 20,
                    height: 20,
                  ),
                  activeColorOverride: (i) => colors[i])),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => categoryScreen()));
                  },
                  child: const Text(
                    "See all",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const ListContainer1(),
          const SizedBox(height: 20),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Popular",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ListContainer2(
            s1: Axis.horizontal,
          ),
          const SizedBox(
            height: 30,
          )
        ]),
      ),
    );
  }

  void signout() async {
    final googleAccount = GoogleSignIn();
    googleAccount.signOut();
    print("normal email signout $uid");
    await auth.signOut();
    Navigator.push(context, MaterialPageRoute(builder: ((context) => Login())));
  }

  Future<void> getUserData() async {
    // final uid=GoogleButton().authResult.user
    if (user == null) {
      print("user is not exist");
    } else {
      try {
        final user = auth.currentUser!.uid;
        final DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection("users")
            .doc(user)
            .get();
        print(user);
        // id=userDoc.get('id');
        setState(() {
          photo = snapshot.get('imageurl');
          name = snapshot.get('name');
          email = snapshot.get('email');
          // password=snapshot.get('password');
        });
      } on FirebaseException catch (error) {
        Fluttertoast.showToast(msg: error.code);
      } catch (error) {
        Fluttertoast.showToast(msg: error.toString());
      }
    }
  }
}

final colors = [
  Colors.greenAccent,
  Colors.amberAccent,
  Colors.indigo,
  Colors.redAccent
];
