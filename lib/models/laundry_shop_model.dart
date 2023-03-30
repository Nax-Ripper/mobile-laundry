import 'dart:convert';

import 'package:flutter/foundation.dart';

class LaundryShop {
  final int id;
  final String imageUrl;
  final String name;
  final List<String> tags;
  final int deliveryTime;
  final double deliveryFee;
  final double distance;
  LaundryShop({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.tags,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.distance,
  });

  LaundryShop copyWith({
    int? id,
    String? imageUrl,
    String? name,
    List<String>? tags,
    int? deliveryTime,
    double? deliveryFee,
    double? distance,
  }) {
    return LaundryShop(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      tags: tags ?? this.tags,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      distance: distance ?? this.distance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'tags': tags,
      'deliveryTime': deliveryTime,
      'deliveryFee': deliveryFee,
      'distance': distance,
    };
  }

  factory LaundryShop.fromMap(Map<String, dynamic> map) {
    return LaundryShop(
      id: map['id']?.toInt() ?? 0,
      imageUrl: map['imageUrl'] ?? '',
      name: map['name'] ?? '',
      tags: List<String>.from(map['tags']),
      deliveryTime: map['deliveryTime']?.toInt() ?? 0,
      deliveryFee: map['deliveryFee']?.toDouble() ?? 0.0,
      distance: map['distance']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LaundryShop.fromJson(String source) => LaundryShop.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LaundryShop(id: $id, imageUrl: $imageUrl, name: $name, tags: $tags, deliveryTime: $deliveryTime, deliveryFee: $deliveryFee, distance: $distance)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LaundryShop &&
      other.id == id &&
      other.imageUrl == imageUrl &&
      other.name == name &&
      listEquals(other.tags, tags) &&
      other.deliveryTime == deliveryTime &&
      other.deliveryFee == deliveryFee &&
      other.distance == distance;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      imageUrl.hashCode ^
      name.hashCode ^
      tags.hashCode ^
      deliveryTime.hashCode ^
      deliveryFee.hashCode ^
      distance.hashCode;
  }
}
