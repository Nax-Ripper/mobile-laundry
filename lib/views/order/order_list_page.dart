// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/order_list_controller.dart';
import 'package:mobile_laundry/routes/route_name.dart';
import 'package:mobile_laundry/widgets/normal_appbar.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    void displayPersistentBottomSheet() {
      Scaffold.of(context).showBottomSheet<void>((BuildContext context) {
        return Container(
          color: Colors.amber,
          height: 200, // 👈 Change this according to your need
          child: const Center(child: Text("Image Filter Here")),
        );
      });
    }

    OrderListController ctrl = Get.put(OrderListController(), permanent: true);
    return GetBuilder<OrderListController>(
      // init: Get.put(OrderListController(), permanent: true),
      // init: OrderListController(),
      init: ctrl,
      builder: (ctrl) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: NormalAppBar(
            title: 'Orders List',
            isCenter: false,
          ),
          body: Column(
            children: [
              Center(
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Card(
                          elevation: 5,
                          child: InkWell(
                            onTap: () {
                              log('orderList $i');
                              for (var j = 0; j < ctrl.services.length; j++) {
                                ctrl.services[j].isSelected = false;
                              }
                              ctrl.services[i].isSelected = true;

                              ctrl.update();
                            },
                            child: Container(
                              width: 110,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ctrl.services[i].isSelected == true ? GlobalVariables.primaryColor : Colors.white,
                                shape: BoxShape.rectangle,
                                boxShadow: [
                                  BoxShadow(color: Colors.pink),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  ctrl.services[i].name,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                        color: ctrl.services[i].isSelected == true ? Colors.white : GlobalVariables.primaryColor,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: ctrl.items.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                          padding: EdgeInsets.all(8),
                          height: 90,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(244, 214, 212, 212).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ctrl.items[i].image,
                                  SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        ctrl.items[i].name,
                                        style: Theme.of(context).textTheme.displaySmall!.copyWith(color: GlobalVariables.primaryColor),
                                      ),
                                      Text(
                                        'RM ${ctrl.items[i].price}',
                                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                              color: Color.fromARGB(255, 173, 16, 69),
                                              fontFamily: 'Futura',
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (ctrl.totalQty.value > 0) {
                                        ctrl.totalQty.value--;
                                      }
                                      if (ctrl.items[i].quantity > 0) {
                                        ctrl.items[i].quantity--;
                                      }
                                      if (ctrl.totalAmount.value > 0.0) {
                                        ctrl.totalAmount.value -= ctrl.items[i].price;
                                      }

                                      if (ctrl.totalQty.value == 0) ctrl.isVisible.value = false;
                                      ctrl.update();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: GlobalVariables.primaryColor),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(Icons.remove),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '${ctrl.items[i].quantity}',
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(color: GlobalVariables.primaryColor),
                                  ),
                                  SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      ctrl.totalQty.value++;
                                      ctrl.items[i].quantity++;
                                      ctrl.totalAmount.value += ctrl.items[i].price;
                                      if (ctrl.totalQty.value > 0) ctrl.isVisible.value = true;
                                      ctrl.update();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: GlobalVariables.primaryColor),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              )
                            ],
                          )),
                    );
                  },
                ),
              ),
              Visibility(
                visible: ctrl.isVisible.value,
                maintainState: true,
                maintainAnimation: true,
                child: Container(
                  margin: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    // color: Color.fromARGB(85, 80, 71, 71),
                    color: Color.fromARGB(202, 233, 182, 31),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40.0),
                    ),
                  ),
                  height: 120,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 20),
                                // Icon(Icons.local_shipping_rounded, size: 30),
                                Image.asset('lib/assets/parcel_box.png', height: 30, fit: BoxFit.fill),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total',
                                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: GlobalVariables.primaryColor.withOpacity(0.6)),
                                    ),
                                    Text(
                                      '${ctrl.totalQty.value} items',
                                      style: Theme.of(context).textTheme.displaySmall!.copyWith(color: GlobalVariables.primaryColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Cost',
                                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: GlobalVariables.primaryColor.withOpacity(0.6)),
                                  ),
                                  Text(
                                    'RM ${ctrl.totalAmount}',
                                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                          color: Color.fromARGB(255, 173, 16, 69),
                                          fontFamily: 'Futura',
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: GlobalVariables.primaryColor),
                          onPressed: () {
                            // ctrl.isVisible.value = false;
                            ctrl.update();

                            Navigator.pushNamed(context, RouteName.pickupShedulePage);
                          },
                          child: Text(
                            'Confirm',
                            style: Theme.of(context).textTheme.displaySmall!,
                          ),
                        ),
                      )
                    ],
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
