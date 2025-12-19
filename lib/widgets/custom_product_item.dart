// widgets/custom_product_item.dart
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class CustomProductItem extends StatefulWidget {
  const CustomProductItem({super.key, required this.product});
  final Product product;
  @override
  State<CustomProductItem> createState() => _CustomProductItemState();
}

class _CustomProductItemState extends State<CustomProductItem> {
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
                    onPressed: () {},
                    icon: Icon(
                      Icons.add_circle,
                      size: 32,
                      color: Color(0xff6055D8),
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
