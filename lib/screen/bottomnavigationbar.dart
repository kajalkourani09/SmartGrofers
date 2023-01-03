import 'package:flutter/material.dart';

import 'categoryscreen.dart';
import 'homescreen.dart';
import 'profilescreen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigation();
}

class _BottomNavigation extends State<BottomNavigation> {
  final screens = [HomeScreen(), categoryScreen(), ProfileScreen()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) => setState(() {
                  currentIndex = index;
                }),
            iconSize: 30,
            type: BottomNavigationBarType.shifting,
            unselectedItemColor: Colors.black,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: "Category",
                  backgroundColor: Colors.amber),
                  
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_sharp),
                  label: "Profile",
                  backgroundColor: Colors.green),
            ]));
  }
}
