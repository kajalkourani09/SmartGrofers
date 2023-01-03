// import 'dart:html';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groceryapp/firebase/auth.dart';
import 'package:groceryapp/screen/bottomnavigationbar.dart';
import 'package:groceryapp/screen/declare.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Demo d1 = Demo();
  String photo = "";
  String name = "";
  String email = "";
  String password = "";
  String id = "";
  File? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isButton = false;
  void initState() {
    isButton = false;
    getUserData();
    // pickImage();

  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
  }

  void updateName(String value) {
    setState(() {
      name = value;
      isButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = name;
    emailController.text = email;
    nameController.selection = TextSelection.fromPosition(
        TextPosition(offset: nameController.text.length));

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        GestureDetector(
                            onTap: (() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavigation()))),
                            child: Icon(Icons.arrow_back_ios)),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Complete Your Profile",
                            style: TextStyle(
                              fontSize: 23,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child: ClipOval(
                              child: Image.network(
                                height: 100,
                                photo,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              print("clicked");
                            },
                            child: GestureDetector(
                              onTap: () {
                                print("clicked");
                               
                                pickImage();  
                               
                                
                              },
                              child: Text(
                                "Change Photo",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Name*",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        onChanged: updateName),
                    // onChanged: (value) {
                    // setState(() {
                    //   name = value;
                    //   isButton = true;
                    // });
                    // },
                    // )
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Email*",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.text,
                      enabled: false,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: isButton == true
                            ? () {
                                updateUserData();
                                print("clicked");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavigation()));
                              }
                            : null,
                        child: Text(
                          "Update Profile",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        style: ButtonStyle(
                            fixedSize:
                                MaterialStateProperty.all(Size(500, 50))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageSelect = File(image.path);
      this.image = imageSelect;
      if (user == null) {
        print("exist");
      } else {
        final ref = FirebaseStorage.instance
            .ref()
            .child('userimages')
            .child(name + '.jpg');
        await ref.putFile(this.image!);
        String url = await ref.getDownloadURL();

        try {
          final user = auth.currentUser!.uid;
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user)
              .update({"imageurl": url});
          // getUserData();
        } on FirebaseException catch (error) {
          print(error.code);
        }
      }
    } on PlatformException catch (e) {
      Fluttertoast.showToast(msg: e.code);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> updateUserData() async {
    // final uid=GoogleButton().authResult.user
    if (user == null) {
      print("user is not exist");
    } else {
      try {
        final user = auth.currentUser!.uid;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user)
            .update({"name": nameController.text});
        print(user);
      } on FirebaseException catch (error) {
        Fluttertoast.showToast(msg: error.code);
      } catch (error) {
        Fluttertoast.showToast(msg: error.toString());
      }
    }
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
