// features/product/presentation/widgets/products_grid_view.dart
import 'package:e_commerce_app/features/product/data/models/product_model.dart';
import 'package:e_commerce_app/features/product/presentation/widgets/custom_product_item.dart';
import 'package:flutter/material.dart';

class ProductsGridView extends StatefulWidget {
  const ProductsGridView({super.key, required this.products});
  final List<Product> products;

  @override
  State<ProductsGridView> createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        mainAxisSpacing: 15,
        childAspectRatio: .6,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return CustomProductItem(product: widget.products[index]);
      },
    );
  }
}
