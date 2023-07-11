// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/models/rider_model.dart';

class RiderApprovalController extends GetxController {
  RidersList riders = RidersList();
  bool isLoading = false;

  Future<void> getAppliedRiders() async {
    try {
      riders.riders?.clear();
      var res = await http.get(
        Uri.parse(
          '$uri/api/get-all-applied-riders',
        ),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      log(res.body);

      riders = RidersList.fromJson(res.body);
    } catch (e) {
      log(e.toString());
    }

    update();
  }

  Future<void> approveRider(String? id, BuildContext context) async {
    isLoading = true;
    try {
      var res = await http.post(
        Uri.parse('$uri/api/approve-rider/$id'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (jsonDecode(res.body)['error'] == null) {
        await getAppliedRiders();
      } else {
        CherryToast.error(
          title: jsonDecode(res.body)['error'],
        ).show(context);
      }
    } catch (e) {
      log(e.toString());
    }

    isLoading = false;

    update();
  }

  Future<void> rejectRider(String?id , BuildContext context) async{
    isLoading = true;
          riders.riders?.clear();

    try {
      var res = await http.post(Uri.parse('$uri/api/reject-rider/$id'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
       );
       
       
      log(res.body);
              await getAppliedRiders();

      //  if(jsonDecode(res.body)['error']==null){
      //   await getAppliedRiders();
      //  }else{
      //    CherryToast.error(
      //     title: jsonDecode(res.body)['error'],
      //   ).show(context);
      //  }
    } catch (e) {
      log(e.toString());
      
    }
//  await getAppliedRiders();
    isLoading = false;

    update();
  }

  // Future<void> downloadFile(String url, String filename) async {
  //   try {
  //     log('url : $url , filename : $filename');
  //     // var req = await http.get(
  //     //   Uri.parse(url),
  //     //   headers: {'Content-Type': 'application/json; charset=UTF-8'},
  //     // );
  //     // var bytes = req.bodyBytes;

  //     // log('${req.bodyBytes}');

  //     var appDir = await getTemporaryDirectory();
  //     // var appDir = Directory('/storage/emulated/0/Download');
  //     log(appDir.path);
  //     var filePath = '${appDir.path}/$filename.pdf';
  //     log(filePath);
  //     File file = File(filePath);
  //     // file = await file.writeAsBytes(bytes, flush: true);
  //     var res = await Dio().get(
  //       url,
  //       onReceiveProgress: (count, total) {
  //         log('count : $count');
  //         log('total : $total');
  //       },
  //       options: Options(
  //         responseType: ResponseType.bytes,
  //         followRedirects: false,
  //         receiveTimeout: 0,
          
  //       ),
  //     );

  //     var write = file.openSync(mode: FileMode.write);
  //     write.writeFromSync(res.data);
  //     await write.close();

  //     await OpenFile.open(filePath);



  //   } catch (e) {
  //     log(e.toString());
  //   }

  //   update();
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAppliedRiders();
  }
}
