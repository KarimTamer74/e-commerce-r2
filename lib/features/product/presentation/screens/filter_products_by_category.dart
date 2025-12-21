// features/product/presentation/screens/filter_products_by_category.dart
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_app/features/product/data/models/product_model.dart';
import 'package:e_commerce_app/features/product/presentation/widgets/products_grid_view.dart';
import 'package:flutter/material.dart';

class FilterProductsByCategory extends StatefulWidget {
  const FilterProductsByCategory({super.key, required this.categoryName});
  final String categoryName;
  @override
  State<FilterProductsByCategory> createState() =>
      _FilterProductsByCategoryState();
}

class _FilterProductsByCategoryState extends State<FilterProductsByCategory> {
  Dio dio = Dio();
  List<Product> products = [];
  Future<List<dynamic>> filterProductsByCategory() async {
    Response response = await dio.get(
      'https://dummyjson.com/products/category/${widget.categoryName}',
    );
    Map<String, dynamic> data = response.data;
    for (var element in data['products']) {
      Product model = Product.fromJson(element);
      products.add(model);
    }

    log('products: $products');
    setState(() {});
    return products;
  }

  @override
  void initState() {
    log("${widget.categoryName}");
    filterProductsByCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.categoryName,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: FutureBuilder(
        future: filterProductsByCategory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isEmpty
                ? Center(
                    child: Text(
                      'No Products Found',
                      style: TextStyle(fontSize: 28),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ProductsGridView(products: products),
                  );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
