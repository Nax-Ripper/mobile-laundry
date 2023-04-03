import 'dart:convert';

import 'package:flutter/material.dart';

class LaundryServices {
  final int id;
  final String name;
  final String imageUrl;
  final Image assetImage;
  bool isSelected;
  LaundryServices({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.assetImage,
    required this.isSelected,
  });

  LaundryServices copyWith({
    int? id,
    String? name,
    String? imageUrl,
    Image? assetImage,
    bool? isSelected,
  }) {
    return LaundryServices(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      assetImage: assetImage ?? this.assetImage,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'imageUrl': imageUrl,
  //     // 'assetImage': assetImage.toMap(),
  //     'isSelected': isSelected,
  //   };
  // }

  // factory LaundryServices.fromMap(Map<String, dynamic> map) {
  //   return LaundryServices(
  //     id: map['id']?.toInt() ?? 0,
  //     name: map['name'] ?? '',
  //     imageUrl: map['imageUrl'] ?? '',
  //     assetImage: Image.fromMap(map['assetImage']),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory LaundryServices.fromJson(String source) => LaundryServices.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LaundryServices(id: $id, name: $name, imageUrl: $imageUrl, assetImage: $assetImage, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LaundryServices &&
        other.id == id &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.assetImage == assetImage &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        imageUrl.hashCode ^
        assetImage.hashCode ^
        isSelected.hashCode;
  }

  // factory LaundryServices.fromMap(Map<String, dynamic> map) {
  //   return LaundryServices(
  //     id: map['id']?.toInt() ?? 0,
  //     name: map['name'] ?? '',
  //     imageUrl: map['imageUrl'] ?? '',
  //     assetImage: Image.fromMap(map['assetImage']),
  //     isSelected: map['isSelected'] ?? false,
  //   );
  // }

  // factory LaundryServices.fromJson(String source) => LaundryServices.fromMap(json.decode(source));
}
