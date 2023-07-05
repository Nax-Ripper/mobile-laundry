import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/controllers/rider_controller/approved_rider_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class ApprovedRiderPage extends StatelessWidget {
  const ApprovedRiderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Approved Riders'),
        ),
        body: GetBuilder<ApprovedRiderController>(
          init: ApprovedRiderController(),
          builder: (ctrl) {
            return ListView.builder(
              itemCount: ctrl.approvedRider.riders?.length,
              itemBuilder: (context, i) {
                return Card(
                  shadowColor: Colors.blue,
                  elevation: 20,
                  child: ListTile(
                    title: Text(ctrl.approvedRider.riders?[i].name ?? ''),
                    subtitle: Text('id : ${ctrl.approvedRider.riders?[i].id}'),
                    trailing: GestureDetector(
                      child: Icon(Icons.phone),
                      onTap: () async {
                        Uri url = Uri(
                            scheme: 'tel',
                            path: ctrl.approvedRider.riders?[i].phone);

                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          CherryToast.error(
                                  title: Text('Cant call to this number'))
                              .show(context);
                        }
                      },
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
