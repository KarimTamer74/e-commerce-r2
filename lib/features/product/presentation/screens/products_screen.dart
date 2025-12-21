// features/product/presentation/screens/products_screen.dart
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_app/features/product/data/models/product_model.dart';
import 'package:e_commerce_app/features/product/presentation/screens/filter_products_by_category.dart';
import 'package:e_commerce_app/features/product/presentation/widgets/products_grid_view.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> products = [];
  List<dynamic> categories = [];
  final dio = Dio();
  @override
  void initState() {
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
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FilterProductsByCategory(
                              categoryName: categories[index]['name'],
                            ),
                          ),
                        );
                      },
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
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              flex: 10,
              child: FutureBuilder(
                future: getAllProducts(),
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    return snapShot.data!.isEmpty
                        ? Text("No products")
                        : ProductsGridView(products: products,);
                  } else if (snapShot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapShot.hasError) {
                    return Text("Error");
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //* data['products'] => [{},{},{}] in api
  //* element => {} , {}
  //* elment (map) to model
  Future<List<Product>> getAllProducts() async {
    try {
      Response response = await dio.get('https://dummyjson.com/products');
      Map<String, dynamic> data = response.data;

      for (var element in data['products']) {
        Product model = Product.fromJson(element);
        products.add(model);
      }
      // log("Products: $products");
      setState(() {});
      return products;
    } catch (e) {
      log("Error: $e");
      return [];
    }
  }

  Future<void> getAllCategories() async {
    Response response = await dio.get(
      'https://dummyjson.com/products/categories',
    );

    categories = response.data;
    setState(() {});
    // log('Categories: $categories');
  }
}
//* 1- Model
//* 2- custom widget with variables
//* 3- call custom widget in gridview.builder / listview.builder