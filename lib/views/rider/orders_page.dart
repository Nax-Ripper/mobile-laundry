import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mobile_laundry/controllers/rider_controller/orders_controller.dart';
import 'package:mobile_laundry/views/rider/selected_order_details_page.dart';
import 'package:mobile_laundry/widgets/bottom_bar_rider.dart';
import 'package:mobile_laundry/widgets/normal_appbar.dart';

import '../../controllers/rider_controller/rider_signup_controller.dart';

class OrdersPage extends StatelessWidget {
   OrdersPage({super.key});
  RiderSignupPageController signInedRider =
      Get.find<RiderSignupPageController>();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: NormalAppBar(title: 'Orders', isCenter: false),
        body: GetBuilder<OrdersController>(
          init: OrdersController(),
          builder: (ctrl) {
            if (ctrl.Addresses == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (ctrl.Addresses?.length == 0) {
              return const Center(
                child: Text('No Orders Found'),
              );
              // return const Center(
              //   child: CircularProgressIndicator(),
              // );
            } else {
              return ListView.builder(
                itemCount: ctrl.Addresses?.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 100,
                          child: Card(
                            child: ListTile(
                              tileColor:signInedRider.rider.id==ctrl.riderOrders.riderOrders![i].riderId? Colors.greenAccent:Colors.transparent,
                              onTap: () {
                                
                                log(i.toString());
                                
                               // to Details Page
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => SelectedOrderDetailsPage(
                                        address: ctrl.Addresses?[i],
                                        order: ctrl.riderOrders.riderOrders?[i],
                                      ),
                                    ));
                              },
                              horizontalTitleGap: 50,
                              minVerticalPadding: 10,
                              enabled: true,
                              visualDensity: VisualDensity.adaptivePlatformDensity,
                              isThreeLine: true,
                              dense: false,
                              title: Text('${ctrl.riderOrders.riderOrders?[i].user?.name}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8),
                                  Text('Address: ${ctrl.Addresses?[i]}', overflow: TextOverflow.ellipsis),
                                  SizedBox(height: 8),

                                  Text('Price: RM ${ctrl.riderOrders.riderOrders?[i].totalFee?.toStringAsFixed(2)}')
                                  // SizedBox(height: 8),
                                  // Text('Pick Up at :'),
                                  // SizedBox(height: 8),
                                  // Text('Deliver at :'),
                                ],
                              ),
                              // trailing: ElevatedButton.icon(
                              //   onPressed: () {
                              //     Navigator.pushAndRemoveUntil(
                              //       context,
                              //       MaterialPageRoute(builder: (context) => BottomBarRider(page: 1)),
                              //       (Route<dynamic> route) => false,
                              //     );
                              //   },
                              //   icon: const HeroIcon(HeroIcons.check),
                              //   label: const Text('Accept'),
                              // ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
            }
          },
        ),);
  }
}
