import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_laundry/controllers/order_list_controller.dart';
import 'package:mobile_laundry/controllers/shedule_pickup_controller.dart';
import 'package:mobile_laundry/models/product_model.dart';

class OrderDetailsController extends GetxController {
  OrderListController orderListCtrl = Get.find<OrderListController>();
  SheduleController sheduleCtrl = Get.find<SheduleController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMenuList();
    getSelectedSerivce();
    getSubTotal();
    getRiderFee();
    getTotal();
    getSelectedItemsInfo();
  }

  double subTotal = 0.0;
  int riderFee = 0;
  String selectedSerivce = "";
  List<Product> products = [];

  void getMenuList() {
    log('${orderListCtrl.products[0].name}');
    log('${orderListCtrl.products[0].quantity}');
    log('${orderListCtrl.products[0].price}');
  }

  String getSelectedSerivce() {
    String? selectedSerivce = '';

    for (var service in orderListCtrl.servicesList.service!) {
      if (service.isSelected == true) {
        log(service.name! + ' is selected');
        selectedSerivce = service.name;
      }
    }
    return selectedSerivce ?? '';
  }

  void getSubTotal() {
    subTotal = orderListCtrl.totalAmount.value;
    update();
  }

  void getRiderFee() {
    riderFee = sheduleCtrl.riderFee.value;
    update();
  }

  double getTotal() {
    double total = 0.0;
    total = subTotal + riderFee + orderListCtrl.selectedService.price!;

    return total;
  }

  void getSelectedItemsInfo() {
    List<Product> selectedItems = [];

    for (var items in orderListCtrl.products) {
      if (items.quantity! > 0) {
        selectedItems.add(items);
      }
    }

    products = selectedItems;

    log('selected items  $selectedItems');
  }

  String currentDateTime() {
    DateTime now = DateTime.now();

    String formattedDate = '';

    return formattedDate ='${DateFormat.jm().format(now)} ${DateFormat.yMEd().format(now)}';
  }
}
