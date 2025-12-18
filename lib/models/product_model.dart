// models/product_model.dart
class Product {
  final String image, title;
  double price;
  final String? desc;

  Product({
    required this.image,
    required this.price,
    required this.title,
    this.desc,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      image: json['thumbnail'],
      price: json['price'],
      title: json['title'],
    );
  }
}
