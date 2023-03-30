// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:flutter/material.dart';

String uri = 'http://10.0.2.2:3000';

class GlobalVariables {
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Color.fromARGB(255, 218, 25, 134)!;
  static const unselectedNavBarColor = Colors.black87;
  static const primaryColor = const Color.fromARGB(195, 62, 27, 100);
  static var greyColor = Color.fromARGB(244, 214, 212, 212).withOpacity(0.5);

  static const headers = {'Content-Type': 'application/json; charset=UTF-8'};
  static const String xAuthToken = 'x-auth-token';
}
