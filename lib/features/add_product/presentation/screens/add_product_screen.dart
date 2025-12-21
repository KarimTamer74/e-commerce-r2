// features/add_product/presentation/screens/add_product_screen.dart
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/shared_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _stockController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final Dio dio = Dio();
  bool isLoading = false;
  clearProductDetails() {
    _titleController.clear();
    _descController.clear();
    _stockController.clear();
    _priceController.clear();
    _imageUrlController.clear();
  }

  Future<void> addProduct() async {
    try {
      setState(() {
        isLoading = true;
      });
      final Response response = await dio.post(
        'https://dummyjson.com/products/adsdcsdd',
        data: {
          'title': _titleController.text,
          'description': _descController.text,
          'stock': _stockController.text,
          'price': _priceController.text,
          'thumbnail': _imageUrlController.text,
          'category': 'Smartphone',
        },
      );
      log("Response: $response");
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Product Added Successfuly")));
      clearProductDetails();
    } on DioException catch (e) {
      String errorMessage = e.response?.data.toString() ?? e.message.toString();
      log("Error: $errorMessage");
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('An Error Occured')));
      clearProductDetails();
    } catch (e) {
      log("Error2: $e");
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('An Error Occured')));
      clearProductDetails();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _stockController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add New Product'),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'Product Details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomTextFormField(
                        controller: _titleController,
                        label: 'Title',
                        prefixIcon: const Icon(Icons.title_rounded),
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: _descController,
                        label: 'Description',
                        prefixIcon: const Icon(Icons.description_outlined),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              controller: _stockController,
                              label: 'Stock',
                              keyboardType: TextInputType.number,

                              prefixIcon: const Icon(
                                Icons.inventory_2_outlined,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextFormField(
                              controller: _priceController,
                              label: 'Price',
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),

                              prefixIcon: const Icon(
                                Icons.attach_money_rounded,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: _imageUrlController,
                        label: 'Image Url',
                        prefixIcon: const Icon(Icons.image_rounded),
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyanAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              log(
                                "Title: ${_titleController.text},Price: ${_priceController.text}, Stock: ${_stockController.text}, Description: ${_descController.text}, Image Url: ${_imageUrlController.text}",
                              );
                              await addProduct();
                            }
                          },
                          child: isLoading
                              ? Center(child: CircularProgressIndicator())
                              : const Text(
                                  'Submit Product',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
