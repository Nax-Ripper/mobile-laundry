// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/geo_location_controller.dart';
import 'package:mobile_laundry/controllers/order_list_controller.dart';
import 'package:mobile_laundry/views/home/home_page.dart';
import 'package:mobile_laundry/views/order/order_list_page.dart';
import 'package:mobile_laundry/widgets/profile_page.dart';

class BottomBarCustomer extends StatefulWidget {
  int? page;
  BottomBarCustomer({
    Key? key,
    this.page,
  }) : super(key: key);

  @override
  State<BottomBarCustomer> createState() => _BottomBarCustomerState();
}

class _BottomBarCustomerState extends State<BottomBarCustomer> {
  int page = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = widget.page ?? 0;
  }

  // GeoLocationController locator = Get.find<GeoLocationController>().initialized
  //         ? Get.find<GeoLocationController>()
  //         : Get.put(GeoLocationController());
  GeoLocationController loctor = Get.put(GeoLocationController());
  double bottomBarWidth = 42;

  void setPage(int newPage) {
    setState(() {
      log('newPage:$newPage');
      log('page :$page');
      page = newPage;
    });
    if (page == 2) {
      Get.delete<OrderListController>(force: true);
    }
  }

  List<Widget> pages = [
    HomePage(),
    OrderListPage(),
    // Center(
    //   child: Text('Account Page'),
    // ),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[page],
      bottomNavigationBar: BottomNavigationBar(
        onTap: setPage,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: page == 0
                        ? GlobalVariables.primaryColor
                        : GlobalVariables.backgroundColor,
                    width: 5,
                  ),
                ),
              ),
              child: Icon(Icons.home),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: page == 1
                        ? GlobalVariables.primaryColor
                        : GlobalVariables.backgroundColor,
                    width: 5,
                  ),
                ),
              ),
              child: Icon(Icons.add_box_rounded),
              //  badges.Badge(
              //   badgeContent: Text('2'),
              //   badgeStyle: badges.BadgeStyle(
              //     elevation: 0,
              //     badgeColor: Colors.white,
              //   ),
              //   child: Icon(Icons.add),
              // ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: page == 2
                        ? GlobalVariables.primaryColor
                        : GlobalVariables.backgroundColor,
                    width: 5,
                  ),
                ),
              ),
              child: Icon(Icons.person),
            ),
          ),
        ],
        currentIndex: page,
        selectedItemColor: GlobalVariables.primaryColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
      ),
    );
  }
}
