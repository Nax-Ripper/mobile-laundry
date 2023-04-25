import 'dart:convert';
import 'dart:io';

class Product {
  final String? name;
  final String? description;
  final double? price;
  final List<String>? images;
  String? id;
  String? userId;
  int? quantity;
  Product({
    this.name,
    this.description,
    this.price,
    this.images,
    this.id,
    this.userId,
    this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'images': images,
      'id': id,
      'userId': userId,
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      id: map['_id'],
      userId: map['userId'],
      quantity: map['quantity'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
