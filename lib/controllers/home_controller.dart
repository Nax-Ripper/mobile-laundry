import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/auth_controller.dart';
import 'package:mobile_laundry/models/arguments_model.dart';
import 'package:mobile_laundry/models/last_orders.dart';
import 'package:mobile_laundry/models/orders_model.dart';

import 'package:mobile_laundry/models/service.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  AuthController authUser = Get.find<AuthController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getServices();
    getOrders(id: authUser.user.id);
  }

  Services servicesList = Services();
  bool isServiceLoading = true;
  Args args = Args();
  OrdersLists orderList = OrdersLists();

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

  getServices() async {
    isServiceLoading = true;
    http.Response res = await http.get(
      Uri.parse('$uri/api/get-services'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': authUser.user.token,
      },
    );

    log('${res.body}');

    servicesList = Services.fromJson(res.body);

    log('ServiceList :${servicesList.service![0].name}');
    update();
  }

  getOrders({required String id}) async {
    log(id);
    var res = await http.get(
      Uri.parse('$uri/api/get-orders/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': authUser.user.token,
      },
    );

    log('Orders: ${res.body}');

    orderList = OrdersLists.fromJson(res.body);
    update();

    // log('total Fee${orderList.orders?[0].totalFee}');
  }

  // List<LastOrders> orders = [
  //   LastOrders(orderId: 1, amount: 10, startTime: '10:00 pm', endTime: '12:00 am', StartDate: '17/02/23', EndDate: '17/02/23'),
  //   LastOrders(orderId: 2, amount: 15, startTime: '2:30 pm', endTime: '5:00 am', StartDate: '15/02/23', EndDate: '15/02/23'),
  //   LastOrders(orderId: 3, amount: 7, startTime: '9:25 am', endTime: '12:00 pm', StartDate: '9/02/23', EndDate: '9/02/23'),
  //   LastOrders(orderId: 4, amount: 7, startTime: '9:25 am', endTime: '12:00 pm', StartDate: '6/02/23', EndDate: '6/02/23'),
  //   LastOrders(orderId: 5, amount: 7, startTime: '9:25 am', endTime: '12:00 pm', StartDate: '5/02/23', EndDate: '5/02/23'),
  // ];
}
