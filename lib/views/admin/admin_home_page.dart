// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/controllers/admin_controller/admin_services_controller.dart';
import 'package:mobile_laundry/routes/route_name.dart';
import 'package:mobile_laundry/views/admin/rider_approval/rider_approval_page.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminServicesProduct>(
      init: AdminServicesProduct(),
      builder: (controller) {
        return Scaffold(
          body: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 8.0,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteName.adminServiceListPage);
                },
                child: Card(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text('Services'),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteName.riderApprovalPage);
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return RiderApprovalPage();
                  // },));
                },
                child: Card(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text('Rider Application'),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
