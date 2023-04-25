import 'dart:convert';
import 'dart:developer';

import 'package:geocoding/geocoding.dart';

import 'product.dart';
import 'user.dart';

class RiderOrder {
  String? id;
  String? serviceId;
  List<Product>? products;
  double? subTotal;
  int? riderFee;
  int? serviceFee;
  double? totalFee;
  String? userId;
  String? intendId;
  int? status;
  DateTime? pickUpTime;
  DateTime? deliveryTime;
  double? pickupLat;
  double? pickupLong;
  double? deliveryLat;
  double? deliveryLong;
  double? dobiLat;
  double? dobiLong;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  User? user;
  String? FullAddress;

  RiderOrder({
    this.id,
    this.serviceId,
    this.products,
    this.subTotal,
    this.riderFee,
    this.serviceFee,
    this.totalFee,
    this.userId,
    this.intendId,
    this.status,
    this.pickUpTime,
    this.deliveryTime,
    this.pickupLat,
    this.pickupLong,
    this.deliveryLat,
    this.deliveryLong,
    this.dobiLat,
    this.dobiLong,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.user,
    this.FullAddress,
  });

  factory RiderOrder.fromMap(Map<String, dynamic> data) => RiderOrder(
        id: data['_id'] as String?,
        serviceId: data['serviceId'] as String?,
        products: data['products'] != null ? List<Product>.from(data['products']?.map((x) => Product.fromMap(x))) : null,
        subTotal: data['subTotal']?.toDouble(),
        riderFee: data['riderFee'] as int?,
        serviceFee: data['serviceFee'] as int?,
        totalFee: (data['totalFee'] as num?)?.toDouble(),
        userId: data['userId'] as String?,
        intendId: data['intendId'] as String?,
        status: data['status'] as int?,
        pickUpTime: data['pickUpTime'] == null ? null : DateTime.parse(data['pickUpTime'] as String),
        deliveryTime: data['deliveryTime'] == null ? null : DateTime.parse(data['deliveryTime'] as String),
        pickupLat: (data['pickupLat'] as num?)?.toDouble(),
        pickupLong: (data['pickupLong'] as num?)?.toDouble(),
        deliveryLat: (data['deliveryLat'] as num?)?.toDouble(),
        deliveryLong: (data['deliveryLong'] as num?)?.toDouble(),
        dobiLat: (data['dobiLat'] as num?)?.toDouble(),
        dobiLong: (data['dobiLong'] as num?)?.toDouble(),
        createdAt: data['createdAt'] == null ? null : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null ? null : DateTime.parse(data['updatedAt'] as String),
        v: data['__v'] as int?,
        user: data['user'] == null ? null : User.fromMap(data['user'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'serviceId': serviceId,
        'products': products?.map((e) => e.toMap()).toList(),
        'subTotal': subTotal,
        'riderFee': riderFee,
        'serviceFee': serviceFee,
        'totalFee': totalFee,
        'userId': userId,
        'intendId': intendId,
        'status': status,
        'pickUpTime': pickUpTime?.toIso8601String(),
        'deliveryTime': deliveryTime?.toIso8601String(),
        'pickupLat': pickupLat,
        'pickupLong': pickupLong,
        'deliveryLat': deliveryLat,
        'deliveryLong': deliveryLong,
        'dobiLat': dobiLat,
        'dobiLong': dobiLong,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
        'user': user?.toMap(),
      };

  //  coordinatesToAddress() async {
  //   double? lat = pickupLat;
  //   double? long = pickupLong;

  //   //  List<Placemark> placemarks = await placemarkFromCoordinates(2.499571073897077, 102.85764956066805);
  //   List<Placemark> placemarks = await placemarkFromCoordinates(lat!, long!);

  //   log('$placemarks');

  //   String fullAddress = placemarks[1].street! + placemarks[0].thoroughfare! + placemarks[0].subLocality! + placemarks[0].postalCode! + placemarks[0].locality! + placemarks[0].administrativeArea!;
  //   log(fullAddress);
  //   FullAddress = fullAddress;
  //   // return fullAddress;
  // }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RiderOrder].
  factory RiderOrder.fromJson(String data) {
    return RiderOrder.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RiderOrder] to a JSON string.
  String toJson() => json.encode(toMap());
}
