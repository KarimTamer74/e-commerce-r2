// screens/products_screen.dart
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_app/widgets/custom_product_item.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<dynamic> products = [];
  List<dynamic> categories = [];
  final dio = Dio();
  @override
  void initState() {
    getAllProducts();
    getAllCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Products',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal),
                      ),
                      child: Center(
                        child: Text(
                          categories[index]['name'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              flex: 10,
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                  childAspectRatio: .7,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return CustomProductItem(
                    title: products[index]['title']!,
                    price: products[index]['price']!.toString(),
                    image: products[index]['thumbnail']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getAllProducts() async {
    try {
      Response response = await dio.get('https://dummyjson.com/products');
      Map<String, dynamic> data = response.data;
      products = data['products'];
      // log("Products: $products");
      setState(() {});
    } catch (e) {
      log("Error: $e");
    }
  }

  Future<void> getAllCategories() async {
    Response response = await dio.get(
      'https://dummyjson.com/products/categories',
    );

    categories = response.data;
    setState(() {});
    log('Categories: $categories');
  }
}
//* 1- Model
//* 2- custom widget with variables
//* 3- call custom widget in gridview.builder / listview.builder