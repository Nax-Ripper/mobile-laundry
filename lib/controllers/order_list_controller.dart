import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/models/laundry_services_model.dart';
import 'package:mobile_laundry/models/menu_items_model.dart';

class OrderListController extends GetxController {
  RxInt totalQty = 0.obs;
  RxDouble totalAmount = 0.0.obs;
  RxBool isVisible = false.obs;
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

  List<MenuItems> items = [
    MenuItems(
      id: 1,
      shopId: 1,
      name: 'T-Shirt',
      description: 'This is T-Shirt',
      price: 2,
      quantity: 0,
      image: Image.asset('lib/assets/t-shirt.png'),
    ),
    MenuItems(
      id: 2,
      shopId: 2,
      name: 'Shirt',
      description: 'This is Shirt',
      price: 2,
      quantity: 0,
      image: Image.asset('lib/assets/shirt.png'),
    ),
    MenuItems(
      id: 3,
      shopId: 3,
      name: 'Sleeveless',
      description: 'This is Sleeveless',
      price: 2,
      quantity: 0,
      image: Image.asset('lib/assets/sleevless.png'),
    ),
    MenuItems(
      id: 4,
      shopId: 4,
      name: 'Skirt',
      description: 'This is Skirt',
      price: 2.50,
      quantity: 0,
      image: Image.asset('lib/assets/skirt.png'),
    ),
    MenuItems(
      id: 5,
      shopId: 5,
      name: 'Suit',
      description: 'This is Suit',
      price: 3.50,
      quantity: 0,
      image: Image.asset('lib/assets/suit_2.png'),
    ),
    MenuItems(
      id: 6,
      shopId: 6,
      name: 'Jean',
      description: 'This is Jean',
      price: 3,
      quantity: 0,
      image: Image.asset('lib/assets/jean_2.png'),
    ),
  ].obs;
}
