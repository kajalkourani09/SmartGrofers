import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/providers/cartservice.dart';
import 'package:groceryapp/providers/categoryselectionservice.dart';
import 'package:groceryapp/screen/login.dart';
import 'package:provider/provider.dart';


Future main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  MyApp({super.key});

// final Future<FirebaseApp>_firebaseInitilization=Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    // future: _firebaseInitilization,
    // builder: (context,snapshot){
    //   if(snapshot.hasError){
    //     print("eroor is occured..");
    //   }
    // if(snapshot.connectionState==ConnectionState.waiting){
    //   return Center(child: CircularProgressIndicator());
    // }
    // else{
    //   print("connection is lost");
    //   Fluttertoast.showToast(msg: "error");
    // }

    return MultiProvider(providers: [
      Provider(create: ((_) => CategorySelectionService())),
      ChangeNotifierProvider(create: ((_) => CartService()))
    ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: Login(),
        ));
  }
}



