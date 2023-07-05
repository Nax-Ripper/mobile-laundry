// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/auth_controller.dart';

import 'package:mobile_laundry/models/product_model.dart';
import 'package:mobile_laundry/utils/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_laundry/utils/http_handler.dart';

import '../../routes/route_name.dart';

class AddProductController extends GetxController {
  AuthController authUser = Get.find<AuthController>();

  TextEditingController productName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();

  List<File> images = [];

  void selectImage() async {
    var res = await pickImages();
    images = res;
    update();
  }

  Future<void> uploadProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required List<File> images,
  }) async {
    try {
      final cloudinary = CloudinaryPublic('dnsmji1no', 'rjshfymx');
      List<String> imageUrls = [];
      for (var i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            images[i].path,
            resourceType: CloudinaryResourceType.Image,
            folder: 'Products',
          ),
        );
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        price: price,
        images: imageUrls,
        id: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {'Content-Type': 'application/json; charset=UTF-8', 'x-auth-token': authUser.user.token},
        body: product.toJson(),
      );

      httpHandler(
        res: res,
        context: context,
        onSuccess: () {
          // Navigator.pop(context);
          // Navigator.pop(context);
          Navigator.popAndPushNamed(context, RouteName.adminServiceListPage);
          ElegantNotification.success(description: Text('Product added successfully'));
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
