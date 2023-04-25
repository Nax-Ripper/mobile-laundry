import 'dart:convert';
import 'dart:developer';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpHandler(
    {required http.Response res,
    required BuildContext context,
    required VoidCallback onSuccess}) {
  log('Res : ${res.body}');

  switch (res.statusCode) {
    case 200:
      onSuccess();
      ElegantNotification.success(
        description: Text('Success'),
      ).show(context);
      break;
    case 400:
      ElegantNotification.success(
        description: Text(jsonDecode(res.body)['msg']),
      ).show(context);
      // showSnackBar(
      //   context,
      //   jsonDecode(res.body)['message'],
      // );

      log(res.body);
      break;

    case 500:
      // showSnackBar(
      //   context,
      //   jsonDecode(res.body)['error'],
      // );
      ElegantNotification.error(
        description: jsonDecode(res.body)['error'],
      ).show(context);
      log(res.body);
      break;

    default:
      // showSnackBar(context, res.body);
      ElegantNotification.success(
        description: jsonDecode(res.body),
      ).show(context);
      log(res.body);
  }
}
