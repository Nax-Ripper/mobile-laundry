import 'dart:convert';

import 'rider_order.dart';

class RiderOrders {
  List<RiderOrder>? riderOrders;

  RiderOrders({this.riderOrders});

  factory RiderOrders.fromMap(Map<String, dynamic> data) => RiderOrders(
        riderOrders: (data['riderOrders'] as List<dynamic>?)?.map((e) => RiderOrder.fromMap(e)).toList(),
      );

  Map<String, dynamic> toMap() => {
        'riderOrders': riderOrders?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RiderOrders].
  factory RiderOrders.fromJson(String data) {
    return RiderOrders.fromMap(json.decode(data));
  }

  /// `dart:convert`
  ///
  /// Converts [RiderOrders] to a JSON string.
  String toJson() => json.encode(toMap());
}
