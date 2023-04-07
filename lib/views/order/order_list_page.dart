// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
// import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/order_list_controller.dart';
import 'package:mobile_laundry/routes/route_name.dart';
import 'package:mobile_laundry/widgets/normal_appbar.dart';

class OrderListPage extends StatefulWidget {
  int? selectedIndex;
  OrderListPage({
    Key? key,
    this.selectedIndex,
  }) : super(key: key);

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  @override
  Widget build(BuildContext context) {
    OrderListController ctrl = Get.put(
      OrderListController(),
    );

    @override
    void initState() {
      super.initState();
      ctrl.getMenuItemList();
    }

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
                    itemCount: ctrl.servicesList.service?.length ?? 3,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Card(
                          elevation: 5,
                          child: InkWell(
                            onTap: () {
                              log('orderList $i');
                              for (var j = 0; j < ctrl.servicesList.service!.length; j++) {
                                ctrl.servicesList.service![j].isSelected = false;
                              }
                              ctrl.servicesList.service![i].isSelected = true;

                              ctrl.update();
                            },
                            child: ctrl.servicesList.service == null
                                ? LoadingAnimationWidget.discreteCircle(color: GlobalVariables.primaryColor, size: 30)
                                : Container(
                                    width: 110,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ctrl.servicesList.service![i].isSelected == true ? GlobalVariables.primaryColor : Colors.white,
                                      shape: BoxShape.rectangle,
                                      boxShadow: [
                                        BoxShadow(color: Colors.pink),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        ctrl.servicesList.service![i].name!,
                                        textAlign: TextAlign.center,
                                        // style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                        //       color: ctrl.services[i].isSelected == true ? Colors.white : GlobalVariables.primaryColor,
                                        //       fontWeight: FontWeight.normal,
                                        //     ),
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
                  itemCount: ctrl.products.length,
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
                                  Image.network(ctrl.products[i].images[0]),
                                  SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        ctrl.products[i].name,
                                        // style: Theme.of(context).textTheme.displaySmall!.copyWith(color: GlobalVariables.primaryColor),
                                      ),
                                      Text(
                                        'RM ${double.parse(ctrl.products[i].price.toString()).toStringAsFixed(2)}',

                                        // style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                        //       color: Color.fromARGB(255, 173, 16, 69),
                                        //       fontFamily: 'Futura',
                                        //     ),
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
                                      if (ctrl.products[i].quantity! > 0) {
                                        ctrl.products[i].quantity = ctrl.products[i].quantity! - 1;
                                      }
                                      if (ctrl.totalAmount.value > 0.0) {
                                        ctrl.totalAmount.value -= ctrl.products[i].price;
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
                                    '${ctrl.products[i].quantity}',
                                    // style: Theme.of(context).textTheme.displayMedium!.copyWith(color: GlobalVariables.primaryColor),
                                  ),
                                  SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      ctrl.totalQty.value++;
                                      // ctrl.products[i].quantity++;
                                      ctrl.products[i].quantity = ctrl.products[i].quantity! + 1;
                                      ctrl.totalAmount.value += ctrl.products[i].price;
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
                                      // style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: GlobalVariables.primaryColor.withOpacity(0.6)),
                                    ),
                                    Text(
                                      '${ctrl.totalQty.value} items',
                                      // style: Theme.of(context).textTheme.displaySmall!.copyWith(color: GlobalVariables.primaryColor),
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
                                    // style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: GlobalVariables.primaryColor.withOpacity(0.6)),
                                  ),
                                  Text(
                                    'RM ${double.parse(ctrl.totalAmount.toString()).toStringAsFixed(2)}',
                                    // style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                    //       color: Color.fromARGB(255, 173, 16, 69),
                                    //       fontFamily: 'Futura',
                                    //     ),
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
                            // ctrl.isVisible.value = false;'
                            if (ctrl.checkIsServiceSelected() == true) {
                              Navigator.pushNamed(context, RouteName.pickupShedulePage);
                            } else {
                              log('false');
                              // ElegantNotification.error(
                              //     animation: AnimationType.fromTop,
                              //     description: Text(
                              //       'Please Select Service Type',
                              //     )).show(context);
                              CherryToast.warning(
                                animationDuration: Duration(milliseconds: 1000),
                                title: Text(''),
                                displayTitle: false,
                                description: Text('Please Select Service Type'),
                                animationType: AnimationType.fromTop,
                                // action: Text("Backup data"),
                                // actionHandler: () {
                                //   print("Hello World!!");
                                // },
                              ).show(context);
                            }
                            ctrl.update();
                          },
                          child: Text(
                            'Confirm',
                            // style: Theme.of(context).textTheme.displaySmall!,
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
