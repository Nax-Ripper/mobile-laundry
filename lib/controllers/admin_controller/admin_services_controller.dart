import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/auth_controller.dart';
import 'package:mobile_laundry/controllers/order_list_controller.dart';

import 'package:http/http.dart' as http;
import 'package:mobile_laundry/models/product_model.dart';
import 'package:mobile_laundry/utils/http_handler.dart';

class AdminServicesProduct extends GetxController {
  AuthController authUser = Get.find<AuthController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProduct();
  }

  bool isLoading = true;

  // ProductList productList = ProductList();
  List<Product> products = [];

  getProduct() async {
    isLoading = true;
    http.Response res = await http.get(Uri.parse('$uri/admin/get-product'), headers: {
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
    isLoading = false;
    update();

    // httpHandler(
    //   res: res,
    //   context: Get.context!,
    //   onSuccess: () {
    //     for (var i = 0; i < jsonDecode(res.body); i++) {
    //       products.add(Product.fromJson(jsonEncode(jsonDecode(res.body[i]))));
    //     }
    //     update();

    //     log(products[0].name!);
    //   },
    // );
  }
}
