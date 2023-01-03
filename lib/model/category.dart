import "package:flutter/material.dart";
import 'package:groceryapp/screen/declare.dart';

Demo d1 = Demo();

class Category_item {
  String image;
  Color c1;
  Color c2;
  String title;
  Function onTap;
  List<Product> subcategory;
  Category_item({
    required this.image,
    required this.c1,
    required this.c2,
    required this.title,
    required this.onTap,
    required this.subcategory,
  });
}

class Product {
  String title;
  String price;
  String image;
  List<ProductDetails> productSubCategory;
  Product({
    required this.image,
    required this.title,
    required this.price,
    required this.productSubCategory,
  });
}

class ProductDetails {
  Color c1;
  Color c2;
  String decription;
  List<CartDetails> cartCategory;

  ProductDetails({
    required this.c1,
    required this.c2,
    required this.cartCategory,
    required this.decription,
  });
}

class CartDetails {
  int product_price;
  String unit;
  CartDetails({
    // ignore: non_constant_identifier_names
    required this.product_price,
    required this.unit,
  });
}

// List<Product> FruitList=[
// Product(Image: d1.fruits_apple, title: "Apple", price: "₹294/2x4 pcs"),
// Product(Image: d1.fruits_banana, title: "Apple", price: "₹20/5 pcs"),
// Product(Image: d1.fruits_kivi, title: "Apple", price: "₹₹236/1 kg"),
// Product(Image: d1.fruits_mango, title: "Apple", price: "₹80/3 pcs"),
// Product(Image: d1.fruits_strawberry, title: "Apple", price: "₹308/4 pcs"),
// Product(Image: d1.fruits_grapes, title: "Apple", price: "₹86/10 pcs"),
// ];


// List<Product> VegetablesList=[
// Product(Image: d1.vegetable_carrot, title: "Carrot", price: "₹294/1 kg"),
// Product(Image: d1.vegetable_garlic, title: "Garlic", price: "₹294/1 kg"),
// Product(Image: d1.vegetable_tomato, title: "Tomato", price: "₹294/1 kg"),
// Product(Image: d1.vegetable_potato, title: "Potato", price: "₹294/1 kg"),
// Product(Image: d1.vegetable_onions, title: "Onions", price: "₹294/1 kg"),
// ];


// List<Category> categoryList=[
//   Category(image: d1.fruits, c1: Colors.green, c2: Colors.green.shade100, title: "Fruits",onTap: (){},subcategory:[
//     Product(Image: d1.fruits_apple, title: "Apple", price: "₹294/2x4 pcs"),
//     Product(Image: d1.fruits_banana, title: "Banana", price: "₹20/5 pcs"),
//     Product(Image: d1.fruits_kivi, title: "Kivi", price: "₹236/1 kg"),
//     Product(Image: d1.fruits_mango, title: "Mango", price: "₹80/3 pcs"),
//     Product(Image: d1.fruits_strawberry, title: "Strawberry", price: "₹308/4 pcs"),
//     Product(Image: d1.fruits_grapes, title: "Grapes", price: "₹86/10 pcs"),    
//     ]
//     ),
//   Category(image: d1.vegetables, c1: Colors.orange, c2:Colors.orange.shade100 , title: "Vegetables",onTap: (){},subcategory:[]),
//   Category(image: d1.frozen, c1: Colors.brown, c2:Colors.brown.shade100 , title: "Frozen",onTap: (){},subcategory:[] ),
//   Category(image: d1.bread, c1: Colors.blue, c2: Colors.blue.shade100, title: "Bread",onTap: (){},subcategory: []),
//   Category(image: d1.condiments, c1: Colors.red, c2: Colors.red.shade100, title: "Condiments",onTap: (){},subcategory: []),
//   Category(image: d1.beverages, c1: Colors.purple, c2:Colors.purple.shade100 , title: "Beverages",onTap: (){},subcategory: []),  
//   Category(image: d1.baking, c1: Colors.pink, c2: Colors.pink.shade100, title: "Baking",onTap: (){},subcategory: []),  
// ];