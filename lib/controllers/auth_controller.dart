// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/models/users_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_laundry/utils/http_handler.dart';

class AuthController extends GetxController {
  User user = User(
    address: '',
    id: '',
    password: '',
    name: '',
    email: '',
    token: '',
    type: '',
    version: 0,
    phoneNumber: '',
  );

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
