import 'dart:convert';

class Invoice {
  String name;
  String rate;
  int quantity;
  double amount;
  Invoice({
    required this.name,
    required this.rate,
    required this.quantity,
    required this.amount,
  });

  Invoice copyWith({
    String? name,
    String? rate,
    int? quantity,
    double? amount,
  }) {
    return Invoice(
      name: name ?? this.name,
      rate: rate ?? this.rate,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rate': rate,
      'quantity': quantity,
      'amount': amount,
    };
  }

  factory Invoice.fromMap(Map<String, dynamic> map) {
    return Invoice(
      name: map['name'] ?? '',
      rate: map['rate'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      amount: map['amount']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Invoice.fromJson(String source) => Invoice.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Invoice(name: $name, rate: $rate, quantity: $quantity, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Invoice &&
      other.name == name &&
      other.rate == rate &&
      other.quantity == quantity &&
      other.amount == amount;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      rate.hashCode ^
      quantity.hashCode ^
      amount.hashCode;
  }
}
