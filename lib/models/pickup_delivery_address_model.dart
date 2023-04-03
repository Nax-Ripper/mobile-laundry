import 'dart:convert';

class PickupDelivery {
  String? pickup;
  String? delivery;
  PickupDelivery({
    this.pickup,
    this.delivery,
  });

  PickupDelivery copyWith({
    String? pickup,
    String? delivery,
  }) {
    return PickupDelivery(
      pickup: pickup ?? this.pickup,
      delivery: delivery ?? this.delivery,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pickup': pickup,
      'delivery': delivery,
    };
  }

  factory PickupDelivery.fromMap(Map<String, dynamic> map) {
    return PickupDelivery(
      pickup: map['pickup'],
      delivery: map['delivery'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PickupDelivery.fromJson(String source) =>
      PickupDelivery.fromMap(json.decode(source));

  @override
  String toString() => 'PickupDelivery(pickup: $pickup, delivery: $delivery)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PickupDelivery &&
        other.pickup == pickup &&
        other.delivery == delivery;
  }

  @override
  int get hashCode => pickup.hashCode ^ delivery.hashCode;
}
