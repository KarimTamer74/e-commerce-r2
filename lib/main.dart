// main.dart
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
        '/product_screen': (context) => ProductsScreen(),
        '/sign_up': (context) => SignUpScreen(),
      },
      initialRoute: '/sign_up',
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce',
    );
  }
}



//* apis (products & categories)
//* from json












//* Sign Up
//* Navigation
//* Listview & GridView
//* App Ui