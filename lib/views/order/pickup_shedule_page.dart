// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/geo_location_controller.dart';
import 'package:mobile_laundry/controllers/shedule_pickup_controller.dart';
import 'package:mobile_laundry/routes/route_name.dart';
import 'package:mobile_laundry/widgets/normal_Appbar.dart';

class PickUpShedulePage extends StatefulWidget {
  const PickUpShedulePage({super.key});

  @override
  State<PickUpShedulePage> createState() => _PickUpShedulePageState();
}

class _PickUpShedulePageState extends State<PickUpShedulePage> {
  @override
  Widget build(BuildContext context) {
    var ctrl =
        Get.put<SheduleController>(SheduleController(), permanent: false);
    var geoLocatorCtrl = Get.find<GeoLocationController>();

    @override
    void initState() {
      super.initState();
      ctrl.getRiderFee();
      // geoLocatorCtrl.placemarks.clear();
      geoLocatorCtrl.getCurrentLocation();
      // geoLocatorCtrl.update();
    }

    return WillPopScope(
      onWillPop: () {
        // Get.delete<GeoLocationController>(force: true);

        return Get.delete<SheduleController>(force: true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: NormalAppBar(
          title: 'Schedule A Pickup',
          isCenter: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Price Details',
                  // style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  //       color: Color.fromARGB(255, 31, 102, 159),
                  //       fontSize: 20,
                  //     ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 200,
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
                              // style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              //       color: GlobalVariables.primaryColor,
                              //     ),
                            ),
                            Text(
                              'RM ${double.parse(ctrl.orders.totalAmount.toString()).toStringAsFixed(2)}',
                              // style: Theme.of(context).textTheme.displaySmall!.copyWith(color: GlobalVariables.primaryColor),
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
                                // style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                //       color: GlobalVariables.primaryColor,
                                //     ),
                              ),
                            ),
                            Obx(
                              () => Text(
                                'RM ${ctrl.riderFee.value}',
                                // style: Theme.of(context).textTheme.displaySmall!.copyWith(color: GlobalVariables.primaryColor),
                              ),
                            )
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
                                'Service Fee',
                                // style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                //       color: GlobalVariables.primaryColor,
                                //     ),
                              ),
                            ),
                            Text(
                              'RM ${ctrl.orders.selectedService.price}',
                              // style: Theme.of(context).textTheme.displaySmall!.copyWith(color: GlobalVariables.primaryColor),
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
                              // style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              //       color: GlobalVariables.primaryColor,
                              //     ),
                            ),
                            Obx(
                              () => Text(
                                // 'RM ${ctrl.orders.totalAmount.value + 10}',
                                'RM ${double.parse((ctrl.orders.totalAmount.value + ctrl.riderFee.value + ctrl.orders.selectedServicePrice.value).toString()).toStringAsFixed(2)} ',
                                // 'RM ${ctrl.orders.totalAmount.value + 10}',
                                // style: Theme.of(context).textTheme.displaySmall!.copyWith(color: GlobalVariables.primaryColor),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          log('additem');
                          Navigator.pop(context);
                        },
                        child: Text('Add item +'))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Schedule Date',
                  // style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  //       color: Color.fromARGB(255, 31, 102, 159),
                  //       fontSize: 20,
                  //     ),
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
                            minTime:
                                DateTime.now().add(const Duration(hours: 1)),
                            maxTime:
                                DateTime.now().add(const Duration(days: 10)),
                            theme: DatePickerTheme(
                              doneStyle: TextStyle(
                                  color: GlobalVariables.primaryColor),
                              itemStyle: TextStyle(
                                  color: GlobalVariables.primaryColor),
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
                                // style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SvgPicture.asset('lib/assets/calendar_add.svg',
                                    height: 35),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Obx(
                                      () => Text(
                                        // 'Thu,1 Apr',
                                        DateFormat.MMMEd()
                                            .format(ctrl.pickUpTime.value),
                                        // style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black),
                                      ),
                                    ),
                                    Obx(
                                      () => Text(
                                        DateFormat.jm()
                                            .format(ctrl.pickUpTime.value),
                                        // style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.black),
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
                            maxTime:
                                ctrl.pickUpTime.value.add(Duration(days: 2)),
                            theme: DatePickerTheme(
                              doneStyle: TextStyle(
                                  color: GlobalVariables.primaryColor),
                              itemStyle: TextStyle(
                                  color: GlobalVariables.primaryColor),
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
                                // style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                              ),
                            ),
                            Row(
                              children: [
                                // Image.asset('lib/assets/calendar_check.png'),
                                SvgPicture.asset(
                                    'lib/assets/calendar_check.svg',
                                    height: 35),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Obx(
                                      () => Text(
                                        DateFormat.MMMEd()
                                            .format(ctrl.deliveryTime.value),
                                        // style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black),
                                      ),
                                    ),
                                    Obx(
                                      () => Text(
                                        DateFormat.jm()
                                            .format(ctrl.deliveryTime.value),
                                        // style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.black),
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
                  // style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  //       color: Color.fromARGB(255, 31, 102, 159),
                  //       fontSize: 20,
                  //     ),
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
                                    for (var i = 0;
                                        i < ctrl.payments.length;
                                        i++) {
                                      ctrl.payments[i].isSelected = false;
                                    }

                                    ctrl.payments[index].isSelected = true;

                                    ctrl.update();
                                  },
                                ),
                                title: Text(ctrl.payments[index].name ?? ''),
                                trailing: SvgPicture.asset(
                                    ctrl.payments[index].image ?? '',
                                    height: 30),
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
                  // style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  //       color: Color.fromARGB(255, 31, 102, 159),
                  //       fontSize: 20,
                  //     ),
                ),
              ),
              GetBuilder<SheduleController>(
                init: ctrl,
                builder: (ctrl) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                        // height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: GlobalVariables.greyColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Icon(Icons.circle_outlined, size: 30),
                                  RotatedBox(
                                      quarterTurns: 1,
                                      child: Text('----------')),
                                  // SizedBox(height: 30, child: ),
                                  Icon(Icons.location_on, size: 30),
                                ],
                              ),
                              GetBuilder(
                                init: geoLocatorCtrl,
                                builder: (geoLocatorCtrl) {
                                  return Expanded(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            ctrl.args.index = 1;
                                            ctrl.args.title = 'PickUp Address';
                                            log('pickup');
                                            Navigator.pushNamed(
                                                context, RouteName.locationPage,
                                                arguments: ctrl.args);
                                            ctrl.update();
                                          },
                                          child: geoLocatorCtrl
                                                      .isCurrentLocationLoading
                                                      .value ==
                                                  true
                                              ? LoadingAnimationWidget.waveDots(
                                                  color: GlobalVariables
                                                      .primaryColor,
                                                  size: 50)
                                              : ListTile(
                                                  title: Text(
                                                      '${geoLocatorCtrl.shortAddress1}'),
                                                  subtitle: Text(geoLocatorCtrl
                                                          .FullAddress1 ??
                                                      'test'),
                                                  // title: Text('${geoLocatorCtrl.placemarks[0].name}'),
                                                  // subtitle: Text(
                                                  //   '${geoLocatorCtrl.placemarks[0].street}, ${geoLocatorCtrl.placemarks[0].name} ,${geoLocatorCtrl.placemarks[0].subLocality},${geoLocatorCtrl.placemarks[0].postalCode} , ${geoLocatorCtrl.placemarks[0].administrativeArea} , ${geoLocatorCtrl.placemarks[0].country}',
                                                  // ),
                                                ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: Divider(
                                            thickness: 3,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            ctrl.args.index = 2;
                                            ctrl.args.title =
                                                'Delivery Address';
                                            log('deli');
                                            Navigator.pushNamed(
                                                context, RouteName.locationPage,
                                                arguments: ctrl.args);
                                            ctrl.update();
                                          },
                                          child: geoLocatorCtrl
                                                      .isCurrentLocationLoading
                                                      .value ==
                                                  true
                                              ? LoadingAnimationWidget.waveDots(
                                                  color: GlobalVariables
                                                      .primaryColor,
                                                  size: 50)
                                              : ListTile(
                                                  // title: Text('${ctrl.address.delivery}'),
                                                  // subtitle: Text('Full Address'),
                                                  title: Text(
                                                      '${geoLocatorCtrl.shortAddress1}'),
                                                  subtitle: Text(geoLocatorCtrl
                                                          .FullAddress1 ??
                                                      'test'),
                                                ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        )
                        // Row(
                        //   children: [
                        //     Column(
                        //       children: [
                        //         Icon(Icons.circle_outlined),
                        //        Divider(
                        //         height: 200,
                        //        )
                        //       ],
                        //     )

                        //   ],
                        // )

                        // Column(
                        //   children: [

                        //     // Row(
                        //     //   children: [
                        //     //     Icon(
                        //     //       Icons.circle_outlined,
                        //     //     ),
                        //     //     Column(
                        //     //       children: [
                        //     //         Text(
                        //     //           'Pickup Address',
                        //     //           // style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                        //     //         ),
                        //     //         Text(
                        //     //           ctrl.address.pickup!,
                        //     //           // style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                        //     //         )
                        //     //       ],
                        //     //     ),
                        //     //   ],
                        //     // ),
                        //     // SizedBox(height: 30),

                        //     // Row(
                        //     //   children: [
                        //     //     Icon(
                        //     //       Icons.location_on,
                        //     //     ),
                        //     //     Text(
                        //     //       'Pickup Address',
                        //     //       // style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                        //     //     ),
                        //     //     Text(
                        //     //       ctrl.address.pickup!,
                        //     //       // style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                        //     //     )
                        //     //   ],
                        //     // ),

                        //     // Column(
                        //     //   children: [
                        //     //     Text(
                        //     //       'Pickup Address',
                        //     //       style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                        //     //     ),
                        //     //     Text(
                        //     //       ctrl.address.pickup!,
                        //     //       style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                        //     //     )
                        //     //   ],
                        //     // ),
                        //     // Column(
                        //     //   children: [
                        //     //     Text(
                        //     //       'Pickup Address',
                        //     //       style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                        //     //     ),
                        //     //     Text(
                        //     //       ctrl.address.pickup!,
                        //     //       style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                        //     //     )
                        //     //   ],
                        //     // )
                        //     // ListTile(
                        //     //   title: Text('Pickup Address'),
                        //     //   subtitle: Text(
                        //     //     ctrl.address.pickup!,
                        //     //     style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                        //     //   ),
                        //     // ),
                        //     // ListTile(
                        //     //   title: Text('Delivery Address'),
                        //     //   subtitle: Text(
                        //     //     ctrl.address.delivery!,
                        //     //     style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                        //     //   ),
                        //     // )
                        //   ],
                        // ),

                        ),
                  );
                },
              ),
              GetBuilder(
                init: ctrl,
                builder: (ctrl) {
                  return Column(
                    children: [
                      Center(
                        child: ctrl.payments[0].isSelected == true
                            ? SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, RouteName.orderDetailsPage);
                                  },
                                  child: Text('Place Order'),
                                ),
                              )
                            : SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                    onPressed: () {
                                      // Navigator.pushNamed(
                                      //     context, RouteName.orderDetailsPage);
                                    },
                                    child: Text('Checkout')),
                              ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
