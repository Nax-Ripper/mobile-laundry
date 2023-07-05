import 'dart:developer';

import 'package:get/get.dart';
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/models/rider_model.dart';
import 'package:http/http.dart' as http;

class ApprovedRiderController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAppliedRiders();
  }
   RidersList approvedRider = RidersList();

    Future<void> getAppliedRiders() async {
    try {
      {
        var res = await http.get(
          Uri.parse(
            '$uri/api/get-all-applied-riders?approved=approved',
          ),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        );
        log('Approved ==${res.body}');
        approvedRider = RidersList.fromJson(res.body);

      }

      
    } catch (e) {
      log(e.toString());
    }

    update();
  }
}