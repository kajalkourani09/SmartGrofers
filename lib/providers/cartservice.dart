import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:groceryapp/model/cartitem.dart';
import 'package:groceryapp/model/category.dart';

class CartService extends ChangeNotifier{
  final List<CartItem> _items=[];
  List<CartItem> get items=>(_items);

  void add(CartItem item){
    items.add(item);
    notifyListeners();
  }

  bool isSubProductAddedToCart(Product product){
    return _items.length>0 ? _items.any((CartItem item) => item.category.title==product.title):false;
  }

  // bool get(){
  //   // 
  //   return  _items.forEach((element) {
      
  //   })
    // items.forEach((CartItem item) {
      // return Product p1=item.category;

    // }
    // );
  // }
}