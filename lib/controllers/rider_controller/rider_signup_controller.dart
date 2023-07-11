import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/models/rider_model.dart';
import 'package:mobile_laundry/utils/file_picker.dart';
import 'package:mobile_laundry/widgets/bottom_bar_rider.dart';
import 'package:path_provider/path_provider.dart';

class RiderSignupPageController extends GetxController {
  List<File> icImage = [];
  List<File> drivingLisence = [];
  String icUrl = '';
  String drivingLisenceUrl = '';
  String pdfUrl='';
  RxBool isICUload = false.obs;
  RxBool isLisenceUload = false.obs;

  String name = '';
  String email = '';
  String phoneNumber = '';
  String password = '';
  Riders rider = Riders();
bool isLoading = false;
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

isLoading = true;
var htmlContent =
"""
<!DOCTYPE html>
<html>

<head>
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Roboto&display=swap");

       
     body{
        text-align:center;
        margin: auto;
        font-family: "Roboto", sans-serif;
     }

        .container {
            text-align: center;
            display: flex;
           
            justify-content: space-around;
            flex-wrap: wrap;
            margin-top: 100px;
        }

        .card {
          
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            width: 300px;
            height: 300px;
            

        }

        img {
            width: 100%;
            height: 300px;
            object-fit: contain;
        }
        .user {

            margin-top: auto;
            display: flex;
        }

        .user img {
            border-radius: 50%;
            width: 70px;
            height: 70px;
            margin-right: 10px;
            object-fit: fill;
        }


        footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            padding: 10px 20px;
            background: #666;
            color: white;
        }

        header {
            position: relative;
            top: 0;
            width: 100%;
            height: 80px;
            padding: 10px 20px;
            background: #666;
            color: white;
        }
    </style>
</head>

<header>
    <div class="user">
        <img src="https://e7.pngegg.com/pngimages/13/544/png-clipart-brown-woven-laundry-hamper-beside-towels-laundry-dry-cleaning-clothing-washing-machines-others-miscellaneous-textile-thumbnail.png"
            alt="user" />

        <h4>Rider Application for Laundryfy Service Management System</h4>

</header>


<body>
    <br>
    <br>
    <div class="info">
    <h1>Rider Name : $name </h1>
    <h1>Rider Email : $email </h1>
    <h1>Rider Phone Number : $phone </h1>
    </div>

    </div>
    <div class="container">


        <div class="card">
            

            <div class="">

                <img src="$icURL"
                    alt="ballons" />
            </div>

        </div>
        <div class="card">
            <div class="">
                <img src="$lisenceURL"
                    alt="ballons" />
            </div>

        </div>
    </div>

    
</body>

<footer>
    <p>Laundryfy Service Management System ©2023. All rights reserved.</p>
</footer>

</html>
""";
 final path = (await getExternalStorageDirectory())?.path;
                    
// var targetPath = "path";
var targetFileName = "example_pdf_file";

var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
    htmlContent, path!, targetFileName);
    log(generatedPdfFile.path);

final cloudinary = CloudinaryPublic('dnsmji1no', 'rjshfymx'); 

 CloudinaryResponse cloudinaryResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            generatedPdfFile.path,
            resourceType: CloudinaryResourceType.Image,
            folder: 'Riders/$name',
          ),
        );
    pdfUrl= cloudinaryResponse.secureUrl;

    rider = Riders(
      email: email,
      name: name,
      icURL: icURL,
      lisenceURL: lisenceURL,
      phone: phone,
      pdf: pdfUrl

    );

    // log('$body');

    var res = await http.post(
      Uri.parse('$uri/api/rider/signUp'),
      body: rider.toJson(),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    if (jsonDecode(res.body)['msg'] != null ||
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
      icImage.clear();
      drivingLisence.clear();
      
    }
    isLoading= false;
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

      // log(res.body[0]);
      // log(jsonDecode(res.body)['msg']);

      if(jsonDecode(res.body)['msg']!=null){
        CherryToast.error(title: Text(jsonDecode(res.body)['msg'])).show(context);
      }

      else if (jsonDecode(res.body)['token'] != null) {
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
