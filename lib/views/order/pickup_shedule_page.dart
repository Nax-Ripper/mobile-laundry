// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/shedule_pickup_controller.dart';
import 'package:mobile_laundry/widgets/normal_Appbar.dart';

class PickUpShedulePage extends StatefulWidget {
  const PickUpShedulePage({super.key});

  @override
  State<PickUpShedulePage> createState() => _PickUpShedulePageState();
}

class _PickUpShedulePageState extends State<PickUpShedulePage> {
  @override
  Widget build(BuildContext context) {
    var ctrl = Get.put<SheduleController>(SheduleController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NormalAppBar(
        title: 'Schedule A Pickup',
        isCenter: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Price Details',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Color.fromARGB(255, 31, 102, 159),
                    fontSize: 20,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                // color: GlobalVariables.greyColor,
                color: GlobalVariables.greyColor,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                color: GlobalVariables.primaryColor,
                              ),
                        ),
                        Text(
                          'RM ${ctrl.orders.totalAmount}',
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(color: GlobalVariables.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Text(
                            'Rider Fee',
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: GlobalVariables.primaryColor,
                                ),
                          ),
                        ),
                        Text(
                          'RM 10',
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(color: GlobalVariables.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                color: GlobalVariables.primaryColor,
                              ),
                        ),
                        Text(
                          'RM ${ctrl.orders.totalAmount.value + 10}',
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(color: GlobalVariables.primaryColor),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Schedule Date',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Color.fromARGB(255, 31, 102, 159),
                    fontSize: 20,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: GlobalVariables.greyColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      log('Pick Time');
                      DatePicker.showDateTimePicker(
                        context,
                        minTime: DateTime.now().add(const Duration(hours: 1)),
                        maxTime: DateTime.now().add(const Duration(days: 10)),
                        theme: DatePickerTheme(
                          doneStyle: TextStyle(color: GlobalVariables.primaryColor),
                          itemStyle: TextStyle(color: GlobalVariables.primaryColor),
                          cancelStyle: TextStyle(color: Colors.red),
                          // headerColor: GlobalVariables.primaryColor,
                        ),
                        currentTime: ctrl.pickUpTime.value,
                        onConfirm: (time) {
                          log('$time');
                          ctrl.checkPickUpTime(time, context);
                          // ctrl.pickUpTime.value = time;
                          // ctrl.setDeliveryTime();
                          // ctrl.update();
                        },
                      );
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(7),
                          child: Text(
                            'Pickup Time',
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SvgPicture.asset('lib/assets/calendar_add.svg', height: 35),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Obx(
                                  () => Text(
                                    // 'Thu,1 Apr',
                                    DateFormat.MMMEd().format(ctrl.pickUpTime.value),
                                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black),
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    DateFormat.jm().format(ctrl.pickUpTime.value),
                                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(color: GlobalVariables.greyColor),
                  GestureDetector(
                    onTap: () {
                      log('delivery Time');
                      DatePicker.showDateTimePicker(
                        context,
                        minTime: ctrl.pickUpTime.value,
                        maxTime: ctrl.pickUpTime.value.add(Duration(days: 2)),
                        theme: DatePickerTheme(
                          doneStyle: TextStyle(color: GlobalVariables.primaryColor),
                          itemStyle: TextStyle(color: GlobalVariables.primaryColor),
                          cancelStyle: TextStyle(color: Colors.red),
                          // headerColor: GlobalVariables.primaryColor,
                        ),
                        currentTime: ctrl.deliveryTime.value,
                        onConfirm: (time) {
                          log('$time');
                          ctrl.deliveryTime.value = time;
                        },
                      );
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(7),
                          child: Text(
                            'Delivery Time',
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                          ),
                        ),
                        Row(
                          children: [
                            // Image.asset('lib/assets/calendar_check.png'),
                            SvgPicture.asset('lib/assets/calendar_check.svg', height: 35),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Obx(
                                  () => Text(
                                    DateFormat.MMMEd().format(ctrl.deliveryTime.value),
                                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black),
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    DateFormat.jm().format(ctrl.deliveryTime.value),
                                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Payment method',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Color.fromARGB(255, 31, 102, 159),
                    fontSize: 20,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              // height: 1,
              decoration: BoxDecoration(
                border: Border.all(color: GlobalVariables.greyColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  GetBuilder<SheduleController>(
                    init: ctrl,
                    builder: (ctrl) {
                      return ListView.builder(
                        itemCount: ctrl.payments.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Checkbox(
                              value: ctrl.payments[index].isSelected,
                              onChanged: (value) {
                                for (var i = 0; i < ctrl.payments.length; i++) {
                                  ctrl.payments[i].isSelected = false;
                                }

                                ctrl.payments[index].isSelected = true;

                                ctrl.update();
                              },
                            ),
                            title: Text(ctrl.payments[index].name ?? ''),
                            trailing: SvgPicture.asset(ctrl.payments[index].image ?? '', height: 30),
                          );
                        },
                      );
                    },
                  )
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   itemCount: ctrl.pay.length,
                  //   itemBuilder: (context, i) {
                  //     return Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               Text(
                  //                 ctrl.payments[i].name!,
                  //                 style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  //                       color: GlobalVariables.primaryColor,
                  //                     ),
                  //               ),
                  //             ],
                  //           ),
                  //           SvgPicture.asset(
                  //             ctrl.payments[i].image!,
                  //             height: 30,
                  //           )
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Address',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Color.fromARGB(255, 31, 102, 159),
                    fontSize: 20,
                  ),
            ),
          ),
          GetBuilder<SheduleController>(
            init: ctrl,
            builder: (ctrl) {
              return Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: GlobalVariables.greyColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle_outlined,
                        ),
                        Column(
                          children: [
                            Text(
                              'Pickup Address',
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                            ),
                            Text(
                              ctrl.address.pickup!,
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),

                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                        ),
                        Text(
                          'Pickup Address',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                        ),
                        Text(
                          ctrl.address.pickup!,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                        )
                      ],
                    ),
                    // Column(
                    //   children: [
                    //     Text(
                    //       'Pickup Address',
                    //       style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                    //     ),
                    //     Text(
                    //       ctrl.address.pickup!,
                    //       style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                    //     )
                    //   ],
                    // ),
                    // Column(
                    //   children: [
                    //     Text(
                    //       'Pickup Address',
                    //       style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                    //     ),
                    //     Text(
                    //       ctrl.address.pickup!,
                    //       style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                    //     )
                    //   ],
                    // )
                    // ListTile(
                    //   title: Text('Pickup Address'),
                    //   subtitle: Text(
                    //     ctrl.address.pickup!,
                    //     style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                    //   ),
                    // ),
                    // ListTile(
                    //   title: Text('Delivery Address'),
                    //   subtitle: Text(
                    //     ctrl.address.delivery!,
                    //     style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                    //   ),
                    // )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
