import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/controllers/admin_controller/rider_approval_controller.dart';
import 'package:mobile_laundry/widgets/normal_appbar.dart';

class RiderApprovalPage extends StatelessWidget {
  const RiderApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar(title: 'Riders', isCenter: false),
      body: GetBuilder<RiderApprovalController>(
        init: RiderApprovalController(),
        builder: (ctrl) {
          return ctrl.riders.riders?.length  == null || ctrl.isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: ctrl.riders.riders?.length,
                  itemBuilder: (context, i) {
                    return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 80,
                              child: Card(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      child: Text(
                                        '${ctrl.riders.riders?[i].name}',
                                        // '5',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          tooltip: 'Approve',
                                          onPressed: () {
                                            ctrl.approveRider(
                                                ctrl.riders.riders?[i].id,
                                                context);
                                            ctrl.update();

                                            log('Approve');
                                          },
                                          icon: const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 30,
                                          ),
                                        ),
                                        IconButton(
                                          tooltip: 'Reject',
                                          onPressed: () async{
                                            log('Reject');
                                           await ctrl.rejectRider(ctrl.riders.riders?[i].id,context);
                                            
                                            ctrl.update();
                                          },
                                          icon: const Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                            size: 30,
                                          ),
                                        ),
                                        IconButton(
                                          tooltip: 'Download',
                                          onPressed: () async {
                                            log('Download');

                                            //  await ctrl.downloadFile('${ctrl.riders.riders?[i].pdf}', '${ctrl.riders.riders?[i].name}');
                                            // ctrl.update();

                                            File? file = await FileDownloader
                                                .downloadFile(
                                              url:
                                                  '${ctrl.riders.riders?[i].pdf}',
                                              name:
                                                  '${ctrl.riders.riders?[i].name}',
                                              onDownloadCompleted: (path) async{
                                                // OpenFile.open(
                                                //   path,
                                                //   type: ".pdf",
                                                // );
                                              },
                                            );
                                            log('${file?.path}');
                                          },
                                          icon: const Icon(
                                            Icons.download,
                                            color: Colors.blue,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                  },
                );
        },
      ),
    );
  }
}
