import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/models/rider_model.dart';
import 'package:mobile_laundry/utils/file_picker.dart';
import 'package:mobile_laundry/widgets/bottom_bar_rider.dart';

class RiderSignupPageController extends GetxController {
  List<File> icImage = [];
  List<File> drivingLisence = [];
  String icUrl = '';
  String drivingLisenceUrl = '';
  RxBool isICUload = false.obs;
  RxBool isLisenceUload = false.obs;

  String name = '';
  String email = '';
  String phoneNumber = '';
  String password = '';
  Riders rider = Riders();

  void selectImageAndUpload({required bool isIc, required String name}) async {
    var res = await pickImages();
    if (isIc) {
      icImage = res;
      icUrl = await uploadPic(name: name, images: icImage).then((value) {
        return value[0];
      });
      log('icURL ==> $icUrl');
    } else {
      drivingLisence = res;
      drivingLisenceUrl =
          await uploadPic(name: name, images: drivingLisence).then((value) {
        return value[0];
      });
      log('drivingLisenceURL ==> $icUrl');
    }

    update();
  }

  Future<List<String>> uploadPic({
    required String name,
    required List<File> images,
  }) async {
    List<String> imageUrls = [];
    try {
      final cloudinary = CloudinaryPublic('dnsmji1no', 'rjshfymx');

      for (var i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            images[i].path,
            resourceType: CloudinaryResourceType.Image,
            folder: 'Riders/$name',
          ),
        );
        imageUrls.add(res.secureUrl);
      }
      //  return imageUrls;
    } catch (e) {
      log(e.toString());
    }
    update();
    return imageUrls;
  }

  Future<void> signUpRider({
    required String name,
    required String email,
    required String icURL,
    required String lisenceURL,
    required String phone,
    required BuildContext context,
  }) async {
    rider = Riders(
      email: email,
      name: name,
      icURL: icURL,
      lisenceURL: lisenceURL,
      phone: phone,
    );

    // log('$body');

    var res = await http.post(
      Uri.parse('$uri/api/rider/signUp'),
      body: rider.toJson(),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    if (jsonDecode(res.body)['msg'] != null &&
        jsonDecode(res.body)['error'] != null) {
      // ignore: use_build_context_synchronously
      CherryToast.error(
        animationDuration: Duration(milliseconds: 1000),
        title: Text(''),
        displayTitle: false,
        description: Text('${jsonDecode(res.body)['msg']}'),
        animationType: AnimationType.fromTop,
      ).show(context);
    } else {
      // return true;
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      CherryToast.success(
        title: Text('Your signup was successful!. Wait for the approval'),
        actionHandler: () {
          log('clicked OK');
        },
        // description:
        autoDismiss: false,
      ).show(context);
    }

    log(res.body);
    update();
  }

  Future<void> signInRider({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    var body = {"email": email, "password": password};
    try {
      var res = await http.post(
        Uri.parse('$uri/api/signin?riderQuery=rider'),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      log(res.body);

      if (jsonDecode(res.body)['token'] != null) {
        rider = Riders.fromJson(res.body);

        log(rider.email!);
        // Navigator.popAndPushNamed(context, RouteName.riderOrdersPage);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomBarRider(page: 0)),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      log(e.toString());
    }
    update();
  }
}
