// features/product/presentation/widgets/custom_product_item.dart
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_app/features/product/data/models/product_model.dart';
import 'package:e_commerce_app/features/product/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class CustomProductItem extends StatefulWidget {
  const CustomProductItem({super.key, required this.product});
  final Product product;
  @override
  State<CustomProductItem> createState() => _CustomProductItemState();
}

class _CustomProductItemState extends State<CustomProductItem> {
  final Dio dio = Dio();
  Future<void> deleteProduct({required int id}) async {
    try {
      log("Product Id: $id");
      final Response response = await dio.delete(
        'https://dummyjson.com/products/$id',
      );
      log("Response: $response");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Product with id: $id deleted")));
    } on DioException catch (e) {
      String errorMessage = e.response?.data.toString() ?? e.message.toString();
      log("Error: $errorMessage");
    } catch (e) {
      log("Error2: $e");
    }
  }

  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: widget.product),
          ),
        );
      },
      child: Container(
        width: 144,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 2, color: Colors.green),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    widget.product.image,
                    height: 134,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 10,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isFav = !isFav;
                      });
                    },
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.blueGrey,
                    ),
                    style: IconButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Wrap(
                children: [
                  Column(
                    children: [
                      Text(
                        widget.product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.product.desc ?? 'No Desc',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '\$ ${widget.product.price}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff6055D8),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'Delete Product',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Text(
                              "Are you sure to delete this product?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await deleteProduct(id: widget.product.id!);
                                },
                                child: Text(
                                  'Ok',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                      // await deleteProduct(id: widget.product.id!);
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      size: 32,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
