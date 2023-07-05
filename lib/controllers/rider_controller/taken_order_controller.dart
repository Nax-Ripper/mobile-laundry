import 'dart:convert';
import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/rider_controller/rider_signup_controller.dart';
import 'package:mobile_laundry/models/rider_orders/rider_order.dart';

import '../../models/product_model.dart';

class TakenOrderController extends GetxController {
  RiderSignupPageController signInedRider =
      Get.find<RiderSignupPageController>();

  RiderOrder order = RiderOrder();
  List<Product> products = [];
  TextEditingController optController = TextEditingController();
  String id = '';
  String hash = '';

  TakenOrderController({
    required this.id,
  });

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getOrders(id: id);
  }

  Future<void> getOrders({required String id}) async {
    log(id);
    var res = await http.get(
      Uri.parse('$uri/api/getOrder-by-OrderId/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MjA3Y2EzNWVkMzI3ZjRhMmNiNmJlZCIsImlhdCI6MTY4MDUwNTc4N30.6F-BUUunHmvKL-cv8_rCJOJjPqxaiXyce6mJah4YKHc',
      },
    );

    log('Orders: ${res.body}');

    // orderList = OrdersLists.fromJson(res.body);
    order = RiderOrder.fromJson(res.body);
    // log('${jsonDecode(res.body)['order']['products']}');
    // products = List<Product>.from(jsonDecode(res.body)['order']['products']?.map((x) => Product.fromMap(x)));
    // for (var i = 0; i < jsonDecode(res.body)['order']['products'].length; i++) {
    //   products.add(jsonDecode(res.body)['order']['products'][i]);
    // }

    log(res.body);
    log('name ==> ${order.user?.name}');
    log('products ==> ${order.products}');
    log('verified===>${order.verified}');
    update();
    // log('orders are:${orderList.orders?[0].products}');

    // log('total Fee${orderList.orders?[0].totalFee}');
  }

  Future<void> updateStatus(int status, String orderId) async {
    var res = await http.post(
      Uri.parse('$uri/api/update-stauts/$orderId?status=$status'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MjA3Y2EzNWVkMzI3ZjRhMmNiNmJlZCIsImlhdCI6MTY4MDUwNTc4N30.6F-BUUunHmvKL-cv8_rCJOJjPqxaiXyce6mJah4YKHc',
      },
    );

    log(res.body);

    order = RiderOrder.fromJson(res.body);
    update();
  }

  Future<void> requestOTP() async {
    var res = await http.post(Uri.parse(
        '$uri/api/get-otp?email=${order.user?.email}&riderid=${signInedRider.rider.id}'));
    log(res.body);
    hash = jsonDecode(res.body)['data'];
    log('hash ==> ${hash}');
    update();
  }

  Future<void> verifyOTP(BuildContext context) async {
    log(optController.text);
    var map = jsonEncode({
      "otp": optController.text,
      "hash": hash,
      "email": order.user?.email,
      "riderId": signInedRider.rider.id,
      "orderId": id
    });
    var res =
        await http.post(Uri.parse('$uri/api/verify-otp'), body: map, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MjA3Y2EzNWVkMzI3ZjRhMmNiNmJlZCIsImlhdCI6MTY4MDUwNTc4N30.6F-BUUunHmvKL-cv8_rCJOJjPqxaiXyce6mJah4YKHc',
    });
    log('verify ==> ${res.body}');
    if (jsonDecode(res.body)['message'] == 'Success') {
      getOrders(id: id);
    } else {
      CherryToast.error(title: Text('${jsonDecode(res.body)['message']}'))
          .show(context);
    }

    update();
  }

  //  Future<String> coordinatesToAddress({double? lat, double? long}) async {
  //   List<Placemark> placemarks = await placemarkFromCoordinates(lat!, long!);

  //   log('$placemarks');

  //   fullAddress = '${placemarks[1].street!} ${placemarks[0].thoroughfare!} ${placemarks[0].subLocality!} ${placemarks[0].postalCode!} ${placemarks[0].locality!} ${placemarks[0].administrativeArea!}';
  //   log(fullAddress);
  //   update();
  //   return fullAddress;
  // }
}