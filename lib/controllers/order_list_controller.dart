import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/auth_controller.dart';

import 'package:http/http.dart' as http;
import 'package:mobile_laundry/models/product_model.dart';
import 'package:mobile_laundry/models/service.dart';

class OrderListController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMenuItemList();
    getServices();
  }

  AuthController authUser = Get.find<AuthController>();

  RxInt totalQty = 0.obs;
  RxDouble totalAmount = 0.0.obs;
  RxInt selectedServicePrice = 0.obs;
  RxBool isVisible = false.obs;
  Service selectedService = Service();
  List<Product> products = [];
  Services servicesList = Services();

  // List<LaundryServices> services = [
  //   LaundryServices(
  //     id: 1,
  //     name: 'Wash Only',
  //     imageUrl: 'lib/assets/wash.png',
  //     assetImage: Image.asset('lib/assets/wash.png'),
  //     isSelected: false,
  //   ),
  //   LaundryServices(
  //     id: 2,
  //     name: 'Dry Only',
  //     imageUrl: 'lib/assets/dry.png',
  //     assetImage: Image.asset('lib/assets/dry.png'),
  //     isSelected: false,
  //   ),
  //   LaundryServices(
  //     id: 3,
  //     name: 'Wash and Dry',
  //     imageUrl: 'lib/assets/wash_dry.jpg',
  //     assetImage: Image.asset(
  //       'lib/assets/wash_dry_2.png',
  //       fit: BoxFit.fitWidth,
  //     ),
  //     isSelected: false,
  //   ),
  // ];

  getMenuItemList() async {
    http.Response res = await http.get(
      Uri.parse('$uri/api/get-product'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': authUser.user.token,
      },
    );

    log(res.body);

    products.clear();
    for (var i = 0; i < jsonDecode(res.body).length; i++) {
      products.add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
    }

    update();
  }

  getServices() async {
    http.Response res =
        await http.get(Uri.parse('$uri/api/get-services'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': authUser.user.token,
    });
    log(res.body);

    servicesList = Services.fromJson(res.body);

    log('ServiceList :${servicesList.service![0].name}');
    update();
  }

  bool checkIsServiceSelected() {
    List<bool> isSelectValue = [];
    for (var select in servicesList.service!) {
      isSelectValue.add(select.isSelected!);
    }

    log('$isSelectValue');

    bool isSelect = isSelectValue.contains(true);
    update();
    return isSelect;
  }
}
