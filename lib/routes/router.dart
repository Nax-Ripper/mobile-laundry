// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_laundry/models/arguments_model.dart';
import 'package:mobile_laundry/routes/route_name.dart';
import 'package:mobile_laundry/views/admin/product_services/add_product_page.dart';
import 'package:mobile_laundry/views/admin/product_services/product_page.dart';
import 'package:mobile_laundry/views/auth/auth_page.dart';
import 'package:mobile_laundry/views/checkout/order_details_page.dart';
import 'package:mobile_laundry/views/location/location_page.dart';
import 'package:mobile_laundry/views/order/order_list_page.dart';
import 'package:mobile_laundry/views/order/pickup_shedule_page.dart';

import '../views/home/home_page.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  Args? args = Args();
  switch (routeSettings.name) {
    case RouteName.locationPage:
      args = routeSettings.arguments as Args?;

      return MaterialPageRoute(
        builder: (_) => LocationPage(index: args!.index, title: args!.title),
      );

    case RouteName.homePage:
      return MaterialPageRoute(
        builder: (_) => HomePage(),
      );

    case RouteName.pickupShedulePage:
      return MaterialPageRoute(
        builder: (_) => PickUpShedulePage(),
      );
    case RouteName.orderListPage:
      args = routeSettings.arguments as Args?;
      log('Args :${args!.index}');
      log('${routeSettings.arguments}');

      return MaterialPageRoute(
        builder: (_) => OrderListPage(selectedIndex: args?.index),
      );

    case RouteName.authPage:
      return MaterialPageRoute(
        builder: (_) => AuthPage(),
      );
    case RouteName.orderDetailsPage:
      return MaterialPageRoute(
        builder: (_) => OrderDetailsPage(),
      );

    case RouteName.adminServiceListPage:
      return MaterialPageRoute(builder: (_) => ProductListPage());

    case RouteName.addProuctPage:
      return MaterialPageRoute(builder: (_) => AddProductPage());

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('Page Not Found'),
          ),
        ),
      );
  }
}
