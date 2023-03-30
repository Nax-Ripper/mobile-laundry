import 'dart:convert';

import 'package:flutter/material.dart';

class MenuItems {
  final int id;
  final int shopId;
  final String name;
  final String description;
  final double price;
   int quantity;
  final Image image;
  MenuItems({
    required this.id,
    required this.shopId,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.image,
  });

  MenuItems copyWith({
    int? id,
    int? shopId,
    String? name,
    String? description,
    double? price,
    int? quantity,
    Image? image,
  }) {
    return MenuItems(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopId': shopId,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      // 'image': image.toMap(),
    };
  }

  // factory MenuItems.fromMap(Map<String, dynamic> map) {
  //   return MenuItems(
  //     id: map['id']?.toInt() ?? 0,
  //     shopId: map['shopId']?.toInt() ?? 0,
  //     name: map['name'] ?? '',
  //     description: map['description'] ?? '',
  //     price: map['price']?.toDouble() ?? 0.0,
  //     quantity: map['quantity']?.toInt() ?? 0,
  //     // image: Image.fromMap(map['image']),
  //   );
  // }

  String toJson() => json.encode(toMap());

  // factory MenuItems.fromJson(String source) => MenuItems.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MenuItems(id: $id, shopId: $shopId, name: $name, description: $description, price: $price, quantity: $quantity, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MenuItems &&
      other.id == id &&
      other.shopId == shopId &&
      other.name == name &&
      other.description == description &&
      other.price == price &&
      other.quantity == quantity &&
      other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      shopId.hashCode ^
      name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      image.hashCode;
  }

//   static List<MenuItems> items = [
//     MenuItems(id: 1, shopId: 1, name: 'T-Shirt', description: 'This is T-Shirt', price: 2, quantity: 0),
//     MenuItems(id: 2, shopId: 2, name: 'Shirt', description: 'This is Shirt', price: 2, quantity: 0),
//     MenuItems(id: 3, shopId: 3, name: 'Sleeveless', description: 'This is Sleeveless', price: 2, quantity: 0),
//     MenuItems(id: 4, shopId: 4, name: 'Skirt', description: 'This is Skirt', price: 2.50, quantity: 0),
//     MenuItems(id: 5, shopId: 5, name: 'Suit', description: 'This is Suit', price: 3.50, quantity: 0),
//     MenuItems(id: 6, shopId: 6, name: 'Jean', description: 'This is Jean', price: 3, quantity: 0),
//   ];
}
