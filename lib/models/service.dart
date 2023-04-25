import 'dart:convert';

import 'package:flutter/foundation.dart';

class Service {
  String? id;
  String? name;
  String? description;
  String? imageUrl;
  int? v;
  bool? isSelected;
  int? price;
  Service({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.v,
    this.isSelected,
    this.price,
  });

  Service copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    int? v,
    bool? isSelected,
    int? price,
  }) {
    return Service(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      v: v ?? this.v,
      isSelected: isSelected ?? this.isSelected,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'v': v,
      'isSelected': isSelected,
      'price': price,
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['_id'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      v: map['v']?.toInt(),
      isSelected: map['isSelected'],
      price: map['price']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Service.fromJson(String source) =>
      Service.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Service(id: $id, name: $name, description: $description, imageUrl: $imageUrl, v: $v, isSelected: $isSelected, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Service &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        other.v == v &&
        other.isSelected == isSelected &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        imageUrl.hashCode ^
        v.hashCode ^
        isSelected.hashCode ^
        price.hashCode;
  }
}

class Services {
  List<Service>? service;

  Services({this.service});

  factory Services.fromMap(Map<String, dynamic> data) => Services(
        service: (data['service'] as List<dynamic>?)
            ?.map((e) => Service.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'service': service?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Services].
  factory Services.fromJson(String data) {
    return Services.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Services] to a JSON string.
  String toJson() => json.encode(toMap());
}
