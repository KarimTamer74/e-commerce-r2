// widgets/products_grid_view.dart
import 'package:e_commerce_app/widgets/custom_product_item.dart';
import 'package:flutter/material.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({super.key, required this.products});
  final List<dynamic> products;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        mainAxisSpacing: 15,
        childAspectRatio: .7,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return CustomProductItem(
          title: products[index]['title'],
          price: products[index]['price'].toString(),
          image: products[index]['thumbnail'],
        );
      },
    );
  }
}
