// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:developer';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/auth_controller.dart';
import 'package:mobile_laundry/controllers/order_list_controller.dart';
import 'package:mobile_laundry/models/arguments_model.dart';
import 'package:mobile_laundry/models/payments_method_model.dart';

import 'package:http/http.dart' as http;

// enum payments {
//  'payments'
// }

class SheduleController extends GetxController {
  var orders = Get.find<OrderListController>();
  RxBool isLoading = false.obs;
  RxBool isSelected = true.obs;

  RxInt riderFee = 0.obs;

  Rx<DateTime> pickUpTime = DateTime.now().add(const Duration(hours: 1)).obs;
  Rx<DateTime> deliveryTime = DateTime.now().add(const Duration(hours: 3)).obs;
  AuthController authUser = Get.find<AuthController>();
  Args args = Args();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getRiderFee();
    void setDeliveryTime() {
      deliveryTime.value = pickUpTime.value.add(const Duration(hours: 3));
      // update();
    }
  }

  void checkPickUpTime(DateTime time, BuildContext context) {
    if (!time.isBefore(DateTime.now())) {
      pickUpTime.value = time;
      deliveryTime.value = pickUpTime.value.add(const Duration(hours: 3));
    } else {
      ElegantNotification.error(
        animation: AnimationType.fromTop,
        title: Text('Error',
            style: TextStyle(
              color: Colors.red,
              fontSize: 13,
            )),
        description: Text(
          'Date Not Available, Please select a correct date',
          // style: Theme.of(context).textTheme.displaySmall!.copyWith(
          //       color: GlobalVariables.primaryColor,
          //     ),
        ),
      ).show(context);
    }
  }

  List<PaymentMethods> payments = [
    PaymentMethods(
      id: 1,
      name: 'Online',
      image: 'lib/assets/globe_solid.svg',
      isSelected: true,
    ),
    // PaymentMethods(
    //   id: 2,
    //   name: 'Cash On Delivery',
    //   image: 'lib/assets/cod_2.svg',
    //   isSelected: true,
    // ),
  ];

  // PickupDelivery address = PickupDelivery(
  //   delivery: 'KP UTM',
  //   pickup: 'KP UTM',
  // );

  getRiderFee() async {
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/get-rider-fee'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': authUser.user.token,
      });

      log(res.body);
      log('${json.decode(res.body)['riderFee']}');

      riderFee.value = json.decode(res.body)['riderFee'];
      update();
    } catch (e) {
      log(e.toString());
    }
  }
}
