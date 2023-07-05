// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/controllers/admin_controller/admin_services_controller.dart';
import 'package:mobile_laundry/routes/route_name.dart';
import 'package:mobile_laundry/views/auth/auth_page.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminServicesProduct>(
      init: AdminServicesProduct(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Welcome Admin'),
            actions: [
              IconButton(
                  onPressed: () {
                    log('lgout');
                    //  AdminServicesProduct
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => AuthPage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: Icon(
                    Icons.logout,
                    size: 30,
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 8.0,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, RouteName.adminServiceListPage);
                  },
                  child: Card(
                  elevation: 30,shadowColor: Colors.amber,
                    child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Total Products',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.orange),
                                ),
                                SizedBox(height: 10),
                                Material(
                                  color: Colors.orangeAccent,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Icon(Icons.delete, size: 20),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '30',
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ],
                        )),
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
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.profilePage);
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
                        child: Text('Admin Profile'),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.adminAssetsPage);
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
                        child: Text('Admin Assets'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
