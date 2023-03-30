// ignore_for_file: prefer_const_constructors

import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/order_list_controller.dart';
import 'package:mobile_laundry/models/payments_method_model.dart';
import 'package:mobile_laundry/models/pickup_delivery_address_model.dart';

// enum payments {
//  'payments'
// }

class SheduleController extends GetxController {
  var orders = Get.find<OrderListController>();
  RxBool isLoading = false.obs;
  RxBool isSelected = true.obs;

  Rx<DateTime> pickUpTime = DateTime.now().add(const Duration(hours: 1)).obs;
  Rx<DateTime> deliveryTime = DateTime.now().add(const Duration(hours: 3)).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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
              fontSize: 17,
            )),
        description: Text(
          'Date Not Available, Please select a correct date',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: GlobalVariables.primaryColor,
              ),
        ),
      ).show(context);
    }
  }

  List<PaymentMethods> payments = [
    PaymentMethods(
      id: 1,
      name: 'Online',
      image: 'lib/assets/globe_solid.svg',
      isSelected: false,
    ),
    PaymentMethods(
      id: 2,
      name: 'Cash On Delivery',
      image: 'lib/assets/cod_2.svg',
      isSelected: true,
    ),
  ];

  PickupDelivery address = PickupDelivery(
    delivery: 'KP UTM',
    pickup: 'KP UTM',
  );
}
