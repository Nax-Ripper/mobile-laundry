// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_laundry/routes/route_name.dart';
import 'package:mobile_laundry/views/location/location_page.dart';
import 'package:mobile_laundry/views/order/pickup_shedule_page.dart';

import '../views/home/home_page.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case RouteName.locationPage:
      return MaterialPageRoute(
        builder: (_) => LocationPage(),
      );

    case RouteName.homePage:
      return MaterialPageRoute(
        builder: (_) => HomePage(),
      );

    case RouteName.pickupShedulePage:
      return MaterialPageRoute(
        builder: (_) => PickUpShedulePage(),
      );

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
