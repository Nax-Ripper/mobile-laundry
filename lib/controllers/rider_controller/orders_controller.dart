import 'dart:convert';
import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/auth_controller.dart';
import 'package:mobile_laundry/models/rider_orders/rider_orders.dart';

class OrdersController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllOrders();
    // coordinatesToAddress();
  }

  // ListRiderOrders riderOrders = ListRiderOrders(riderOrders: []);
  RiderOrders riderOrders = RiderOrders();
  AuthController auth = AuthController();
  List<Placemark> placemarks = [];
  String fullAddress = 'no address';
  List<String>? Addresses = [];

  Future<String> coordinatesToAddress({double? lat, double? long}) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat!, long!);

    log('$placemarks');

    fullAddress = '${placemarks[1].street!}${placemarks[0].thoroughfare!}${placemarks[0].subLocality!}${placemarks[0].postalCode!}${placemarks[0].locality!}${placemarks[0].administrativeArea!}';
    log(fullAddress);
    update();
    return fullAddress;
  }

  Future<void> getAllOrders() async {
    http.Response res = await http.get(
      Uri.parse('$uri/api/get-orders/all'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        // 'x-auth-token': auth.user.token,
        'x-auth-token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MjA3Y2EzNWVkMzI3ZjRhMmNiNmJlZCIsImlhdCI6MTY4MDUwNTc4N30.6F-BUUunHmvKL-cv8_rCJOJjPqxaiXyce6mJah4YKHc',
      },
    );

    log(res.body);

    riderOrders = RiderOrders.fromJson(res.body);
    for (var i = 0; i < riderOrders.riderOrders!.length; i++) {
      coordinatesToAddress(lat: riderOrders.riderOrders?[i].pickupLat, long: riderOrders.riderOrders?[i].pickupLong).then((value) {
        log(' value ==> $value');
        Addresses?.add(value);
      });
    }

    // log('$Addresses');

    update();
  }
}
