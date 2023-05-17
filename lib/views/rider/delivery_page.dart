import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:mobile_laundry/controllers/rider_controller/taken_order_controller.dart';
import 'package:mobile_laundry/widgets/bottom_bar_rider.dart';

import 'package:mobile_laundry/widgets/custom_textfields.dart';
import 'package:mobile_laundry/widgets/normal_appbar.dart';

import '../../models/rider_orders/product.dart';

TextEditingController optController = TextEditingController();

class DeliveryPage extends StatelessWidget {
  String? id;
  DeliveryPage({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TakenOrderController>(
      init: TakenOrderController(id: id ?? ''),
      builder: (takenCtrl) {
        return Scaffold(
          appBar: NormalAppBar(title: 'Taken Order ', isCenter: false),
          body: id == ''
              ? const Center(
                  child: Text('No orders '),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Container(
                    // height: 7000,
                    // constraints: BoxConstraints(maxHeight: context.height, minHeight: 700),
                    child: ListView(
                      // shrinkWrap: true,
                      children: [
                        Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Order Details'),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Text(
                                              '${takenCtrl.order.serviceName}',
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Text('${takenCtrl.order.user?.name}'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    OrderItems(takenCtrl.order.products ?? []),
                                    const Divider(
                                      color: Colors.black,
                                    ),
                                    ListTile(
                                      subtitle: Text('Online'),
                                      title: Text('Payment'),
                                      trailing: Text('RM ${double.tryParse(takenCtrl.order.totalFee.toString())?.toStringAsFixed(2)}'),
                                    ),
                                    Container(
                                      constraints: const BoxConstraints(maxHeight: 300),
                                      child: ListView(
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        children: [
                                          const SizedBox(height: 20),
                                          Visibility(
                                            visible: true,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Card(
                                                elevation: 15,
                                                child: ListTile(
                                                  onTap: () {
                                                    log('pickUp');
                                                    MapsLauncher.launchCoordinates(takenCtrl.order.pickupLat!, takenCtrl.order.pickupLong!, 'PickUp');
                                                  },
                                                  leading: const Icon(Icons.location_on),
                                                  // title: Text(widget.address ?? ''),
                                                  title: Text('PickUp'),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: true,
                                            child: RotatedBox(
                                              quarterTurns: 4,
                                              // child: Text('---------->'),
                                              child: Column(
                                                children: List.generate(
                                                    3,
                                                    (index) => const Icon(
                                                          Icons.circle,
                                                          size: 10,
                                                        )),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: takenCtrl.order.status == 1,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Card(
                                                elevation: 15,
                                                child: ListTile(
                                                  onTap: () {
                                                    log('Dobi');
                                                    MapsLauncher.launchCoordinates(
                                                      takenCtrl.order.dobiLat!,
                                                      takenCtrl.order.dobiLong!,
                                                    );
                                                  },
                                                  leading: const Icon(Icons.factory),
                                                  title: Text('Dobi'),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: takenCtrl.order.status == 1,
                                            child: RotatedBox(
                                              quarterTurns: 4,
                                              child: Column(
                                                children: List.generate(
                                                    3,
                                                    (index) => const Icon(
                                                          Icons.circle,
                                                          size: 10,
                                                        )),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: takenCtrl.order.status == 1,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Card(
                                                elevation: 15,
                                                child: ListTile(
                                                  onTap: () {
                                                    log('DropOff');
                                                    MapsLauncher.launchCoordinates(takenCtrl.order!.pickupLat!, takenCtrl.order!.pickupLong!, 'Delivery');
                                                  },
                                                  leading: const Icon(Icons.home),
                                                  title: Text('Delivery'),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // const SizedBox(height: 10),
                                          // Row(
                                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          //   children: [
                                          //     SizedBox(
                                          //       width: 250,
                                          //       child: CustomTextField(
                                          //         controller: optController,
                                          //         hintText: 'Enter OTP',
                                          //       ),
                                          //     ),
                                          //     SizedBox(
                                          //       height: 57,
                                          //       child: ElevatedButton(
                                          //         onPressed: () {},
                                          //         child: const Text('verify'),
                                          //       ),
                                          //     )
                                          //   ],
                                          // ),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Divider(thickness: 0.3, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: SizedBox(
                                    width: 250,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          log('Hello');
                                          if (takenCtrl.order.status == 2) {
                                            takenCtrl.updateStatus(1, takenCtrl.order.id!);
                                            takenCtrl.update();
                                          }
                                          if (takenCtrl.order.status == 1) {
                                            takenCtrl.updateStatus(0, takenCtrl.order.id!);
                                            takenCtrl.getOrders(id: id!);
                                            takenCtrl.update();
                                          }
                                          if (takenCtrl.order.status == 0) {
                                            // call api to crate past order with {riderId, OrderId}
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(builder: (context) => BottomBarRider(page: 2)),
                                              (Route<dynamic> route) => false,
                                            );
                                          }
                                        },
                                        child: takenCtrl.order.status == 2
                                            ? const Text('Picked Up')
                                            : takenCtrl.order.status == 1
                                                ? const Text('Deliver')
                                                : takenCtrl.order.status == 0
                                                    ? Text('Done')
                                                    : null),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}

Widget OrderItems(List<Product> product) {
  return ExpansionTile(
    title: Text('Order Items (${product.length} Categories)'),
    expandedCrossAxisAlignment: CrossAxisAlignment.start,
    expandedAlignment: Alignment.centerLeft,
    children: List.generate(
      product.length,
      (index) => Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('${product[index].name}'), Text('x ${product[index].quantity}')],
        ),
      ),
    ),
  );
}
