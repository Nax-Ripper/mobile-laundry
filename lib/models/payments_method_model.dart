import 'dart:convert';

class PaymentMethods {
  int? id;
  String? name;
  String? image;
  bool? isSelected;
  PaymentMethods({
    this.id,
    this.name,
    this.image,
    this.isSelected,
  });

  PaymentMethods copyWith({
    int? id,
    String? name,
    String? image,
    bool? isSelected,
  }) {
    return PaymentMethods(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isSelected': isSelected,
    };
  }

  factory PaymentMethods.fromMap(Map<String, dynamic> map) {
    return PaymentMethods(
      id: map['id']?.toInt(),
      name: map['name'],
      image: map['image'],
      isSelected: map['isSelected'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethods.fromJson(String source) => PaymentMethods.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaymentMethods(id: $id, name: $name, image: $image, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PaymentMethods &&
      other.id == id &&
      other.name == name &&
      other.image == image &&
      other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      image.hashCode ^
      isSelected.hashCode;
  }
}
