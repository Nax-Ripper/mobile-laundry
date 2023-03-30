import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/models/last_orders.dart';
import 'package:mobile_laundry/models/laundry_services_model.dart';

class HomeController extends GetxController {
  List<LaundryServices> services = [
    LaundryServices(
      id: 1,
      name: 'Wash Only',
      imageUrl: 'lib/assets/wash.png',
      assetImage: Image.asset('lib/assets/wash.png'),
      isSelected: false,
    ),
    LaundryServices(
      id: 2,
      name: 'Dry Only',
      imageUrl: 'lib/assets/dry.png',
      assetImage: Image.asset('lib/assets/dry.png'),
      isSelected: false,
    ),
    LaundryServices(
      id: 3,
      name: 'Wash and Dry',
      imageUrl: 'lib/assets/wash_dry.jpg',
      assetImage: Image.asset(
        'lib/assets/wash_dry_2.png',
        fit: BoxFit.fitWidth,
      ),
      isSelected: false,
    ),
  ];

  List<LastOrders> orders = [
    LastOrders(orderId: 1, amount: 10, startTime: '10:00 pm', endTime: '12:00 am', StartDate: '17/02/23', EndDate: '17/02/23'),
    LastOrders(orderId: 2, amount: 15, startTime: '2:30 pm', endTime: '5:00 am', StartDate: '15/02/23', EndDate: '15/02/23'),
    LastOrders(orderId: 3, amount: 7, startTime: '9:25 am', endTime: '12:00 pm', StartDate: '9/02/23', EndDate: '9/02/23'),
    LastOrders(orderId: 4, amount: 7, startTime: '9:25 am', endTime: '12:00 pm', StartDate: '6/02/23', EndDate: '6/02/23'),
    LastOrders(orderId: 5, amount: 7, startTime: '9:25 am', endTime: '12:00 pm', StartDate: '5/02/23', EndDate: '5/02/23'),
  ];
}
