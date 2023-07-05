import 'dart:convert';
import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/admin_controller/rider_approval_controller.dart';
import 'package:mobile_laundry/controllers/auth_controller.dart';
import 'package:mobile_laundry/controllers/order_list_controller.dart';

import 'package:http/http.dart' as http;
import 'package:mobile_laundry/models/product_model.dart';
import 'package:mobile_laundry/models/rider_model.dart';
import 'package:mobile_laundry/models/rider_orders/rider_orders.dart';
import 'package:mobile_laundry/utils/http_handler.dart';

class AdminServicesProduct extends GetxController {
  AuthController authUser = Get.find<AuthController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProduct();
    getAppliedRiders(isApproved: false);
    getAppliedRiders(isApproved: true);
    getAllOrders();
  }

  bool isLoading = true;

  int productCount = 0;

  // ProductList productList = ProductList();
  List<Product> products = [];
  RidersList appliedRiders = RidersList();
  RidersList approvedRider = RidersList();
   RiderOrders riderOrders = RiderOrders();


    Future<void> getAllOrders() async {
    http.Response res = await http.get(
      Uri.parse('$uri/api/get-orders/all'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        // 'x-auth-token': auth.user.token,
        'x-auth-token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MjA3Y2EzNWVkMzI3ZjRhMmNiNmJlZCIsImlhdCI6MTY4MDUwNTc4N30.6F-BUUunHmvKL-cv8_rCJOJjPqxaiXyce6mJah4YKHc',
      },
    );

    log(res.body);

    riderOrders = RiderOrders.fromJson(res.body);
    // for (var i = 0; i < riderOrders.riderOrders!.length; i++) {
    //   coordinatesToAddress(lat: riderOrders.riderOrders?[i].pickupLat, long: riderOrders.riderOrders?[i].pickupLong).then((value) {
    //     log(' value ==> $value');
    //     Addresses?.add(value);
    //   });
    // }

    // log('$Addresses');

    update();
  }

  Future<void> getAppliedRiders({bool isApproved = false}) async {
    try {
      if (isApproved == false) {
        var res = await http.get(
          Uri.parse(
            '$uri/api/get-all-applied-riders',
          ),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        );
        log('pending = ${res.body}');
        appliedRiders = RidersList.fromJson(res.body);
      } else {
        var res = await http.get(
          Uri.parse(
            '$uri/api/get-all-applied-riders?approved=approved',
          ),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        );
        log('Approved ==${res.body}');
        approvedRider = RidersList.fromJson(res.body);

      }

      
    } catch (e) {
      log(e.toString());
    }

    update();
  }

  getProduct() async {
    isLoading = true;
    http.Response res =
        await http.get(Uri.parse('$uri/admin/get-product'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': authUser.user.token,
    });

    log('res: ${res.body}');
    // productList = ProductList.fromJson(res.body);
    // update();
    products.clear();
    for (var i = 0; i < jsonDecode(res.body).length; i++) {
      products.add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
    }
    productCount = res.body.length;
    isLoading = false;
    update();
  }

  deleteProduct(String id, BuildContext context) async {
    try {
      isLoading = true;
      var res = await http.post(
        Uri.parse('$uri/admin/delete-product/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': authUser.user.token,
        },
      );
      products.clear();
      for (var i = 0; i < jsonDecode(res.body).length; i++) {
        products.add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
      }
      isLoading = false;

      update();
    } catch (e) {
      log(e.toString());
    }
  }
}
