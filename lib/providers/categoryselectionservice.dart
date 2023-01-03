import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/model/category.dart';

class CategorySelectionService{
  Category_item _selectedCategory=Category_item(image: "", c1:Colors.black, c2: Colors.black, title: "", onTap: (){}, subcategory: []);
  Product _selectedProduct=Product(image: "", title: "", price:"", productSubCategory: []);

  Product get selectedProduct => _selectedProduct;

  set selectedProduct(Product selectedProduct) {
    _selectedProduct = selectedProduct;
  }

   Category_item get selectedCategory =>_selectedCategory;
  set selectedCategory(Category_item value){
    _selectedCategory=value;
  }

  
  Product get selectProduct =>_selectedProduct;
  set selectProduct(Product value){
    _selectedProduct=value;
  }
}