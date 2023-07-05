import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/auth_controller.dart';
import 'package:mobile_laundry/models/arguments_model.dart';
import 'package:mobile_laundry/models/invoice_model.dart';
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

    // log('Orders: ${res.body}');

    orderList = OrdersLists.fromJson(res.body);

    log('first delivary ${orderList.orders?.first.deliveryLat}');
    update();
    // log('orders are:${orderList.orders?[0].products}');

    // log('total Fee${orderList.orders?[0].totalFee}');
  }

//   List<Invoice> invoice = [];

//   DataTable buildDataTable = DataTable(columns: [
//     DataColumn(label: Text('hi'))
//   ], rows: []);

//   getInvoice(Orders order) {
//     for (var i = 0; i < order.products!.length; i++) {
//       log("Name==>");
//       log(order.products![i].name!);

//       log(order.products![i].price!.toString());

//       log('quantitiy');
//       log(order.products![i].quantity!.toString());

//       invoice.add(Invoice(
//           name: order.products![i].name!,
//           rate: order.products![i].price.toString(),
//           quantity: order.products![i].quantity!,
//           amount: calculateAmount(
//               order.products![i].price!, order.products![i].quantity!)));
//     }

//     invoice.add(Invoice(
//         name: 'Rider Fee',
//         rate: order.riderFee.toString(),
//         quantity: 1,
//         amount: order.riderFee!.toDouble()));
//     invoice.add(Invoice(
//         name: 'Service Fee',
//         rate: order.serviceFee.toString(),
//         quantity: 1,
//         amount: order.serviceFee!.toDouble()));

//     log('Invoice == >${invoice.length.toString()}  ||  ${invoice.first.amount}');
// final columns = ['Item', 'Rate', 'Quantity', 'Amount'];
//     buildDataTable = DataTable(columns: getColumn(columns), rows: getRows(invoice));
//     update();
//   }

//   double calculateAmount(double price, int quantity) {
//     return price * quantity;
//   }

  
//   List<DataColumn> getColumn(List<String> columns) =>
//       columns.map((String column) => DataColumn(label: Text(column))).toList();

//   // List<DataRow> getRows(List<Invoice> invoices){
//   //    invoices.map((Invoice invoice) {
//   //     final cells = [invoice.name, invoice.rate,invoice.quantity, invoice.amount];
//   //     return DataRow(cells: getCells(cells));
//   //   }).toList();
//   // }

//   List<DataRow> getRows(List<Invoice> invoices) {
//     return invoices.map((Invoice invoice) {
//       final cells = [
//         invoice.name,
//         invoice.rate,
//         invoice.quantity,
//         invoice.amount
//       ];
//       return DataRow(cells: getCells(cells));
//     }).toList();
//   }

//   List<DataCell> getCells(List<dynamic> cells){
//     return cells.map((data) => DataCell(Text('$data'))).toList();
//   }
}
