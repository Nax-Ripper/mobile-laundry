import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_laundry/models/product_model.dart';

class Orders {
  String? serviceId;
  List<Product>? products;
  double? subTotal;
  int? serviceFee;
  double? totalFee;
  String? userId;
  String? intendId;
  DateTime? pickUpTime;
  DateTime? deliveryTime;
  int? riderFee;
  int? status;
  double? pickupLat;
  double? pickupLong;
  double? deliveryLat;
  double? deliveryLong;
  double? dobiLat;
  double? dobiLong;
  Orders({
    this.serviceId,
    this.products,
    this.subTotal,
    this.serviceFee,
    this.totalFee,
    this.userId,
    this.intendId,
    this.pickUpTime,
    this.deliveryTime,
    this.riderFee,
    this.status,
    this.pickupLat,
    this.pickupLong,
    this.deliveryLat,
    this.deliveryLong,
    this.dobiLat,
    this.dobiLong,
  });

  Map<String, dynamic> toMap() {
    return {
      'serviceId': serviceId,
      'products': products?.map((x) => x?.toMap())?.toList(),
      'subTotal': subTotal,
      'serviceFee': serviceFee,
      'totalFee': totalFee,
      'userId': userId,
      'intendId': intendId,
      'pickUpTime': pickUpTime?.millisecondsSinceEpoch,
      'deliveryTime': deliveryTime?.millisecondsSinceEpoch,
      'riderFee': riderFee,
      'status': status,
      'pickupLat': pickupLat,
      'pickupLong': pickupLong,
      'deliveryLat': deliveryLat,
      'deliveryLong': deliveryLong,
      'dobiLat': dobiLat,
      'dobiLong': dobiLong,
    };
  }

  factory Orders.fromMap(Map<String, dynamic> map) {
    return Orders(
      serviceId: map['serviceId'],
      products: map['products'] != null
          ? List<Product>.from(map['products']?.map((x) => Product.fromMap(x)))
          : null,
      subTotal: map['subTotal']?.toDouble(),
      serviceFee: map['serviceFee']?.toInt(),
      totalFee: map['totalFee']?.toDouble(),
      userId: map['userId'],
      intendId: map['intendId'],
      pickUpTime:
          map['pickUpTime'] != null ? DateTime.parse(map['pickUpTime']) : null,
      deliveryTime: map['deliveryTime'] != null
          ? DateTime.parse(map['deliveryTime'])
          : null,
      riderFee: map['riderFee']?.toInt(),
      status: map['status']?.toInt(),
      pickupLat: map['pickupLat']?.toDouble(),
      pickupLong: map['pickupLong']?.toDouble(),
      deliveryLat: map['deliveryLat']?.toDouble(),
      deliveryLong: map['deliveryLong']?.toDouble(),
      dobiLat: map['dobiLat']?.toDouble(),
      dobiLong: map['dobiLong']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Orders.fromJson(String source) => Orders.fromMap(json.decode(source));
}

class OrdersLists {
  List<Orders>? orders;
  OrdersLists({
    this.orders,
  });

  Map<String, dynamic> toMap() {
    return {
      'orders': orders?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory OrdersLists.fromMap(Map<String, dynamic> map) {
    return OrdersLists(
      orders: map['orders'] != null
          ? List<Orders>.from(map['orders']?.map((x) => Orders.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdersLists.fromJson(String source) =>
      OrdersLists.fromMap(json.decode(source));
}
