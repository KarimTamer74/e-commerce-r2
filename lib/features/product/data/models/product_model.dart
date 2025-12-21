// models/product_model.dart
class Product {
  final int? id;
  final String image, title;
  double price;
  final String? desc;
  final double? rating;
  final String? cat;
  Product({
    this.id,
    required this.image,
    required this.price,
    required this.title,
    this.desc,
    this.cat,
    this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      image: json['thumbnail'],
      price: json['price'],
      title: json['title'],
      rating: json['rating'],
      desc: json['description'],
      cat: json['category'],
    );
  }
}
