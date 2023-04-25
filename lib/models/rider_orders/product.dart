import 'dart:convert';

class Product {
  String? name;
  String? description;
  double? price;
  List<String>? images;
  int? quantity;

  Product({
    this.name,
    this.description,
    this.price,
    this.images,
    this.quantity,
  });

  factory Product.fromMap(Map<String, dynamic> data) => Product(
        name: data['name'] as String?,
        description: data['description'] as String?,
        price: (data['price'] as num?)?.toDouble(),
        images: List<String>.from(data['images']),
        quantity: data['quantity'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'description': description,
        'price': price,
        'images': images,
        'quantity': quantity,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Product].
  factory Product.fromJson(String data) {
    return Product.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Product] to a JSON string.
  String toJson() => json.encode(toMap());
}
