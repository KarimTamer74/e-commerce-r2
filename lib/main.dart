// main.dart
import 'package:e_commerce_app/screens/filter_products_by_category.dart';
import 'package:e_commerce_app/screens/products_screen.dart';
import 'package:e_commerce_app/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/sign_up': (context) => SignUpScreen(),
        '/products_screen': (context) => ProductsScreen(),
        '/filter_products_by_category': (context) => FilterProductsByCategory(categoryName: '',),
      },
      initialRoute: '/products_screen',
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce',
    );
  }
}

//* 1- Grid View 
//* 2- custom item (product data)
//* 3- model
//* 4- api request
//* 5- convert data from api to your model using fromJson
//* 6- pass data in model to custom item

