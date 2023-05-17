import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:mobile_laundry/controllers/rider_controller/orders_controller.dart';

import 'package:mobile_laundry/models/rider_orders/rider_order.dart';
import 'package:mobile_laundry/widgets/bottom_bar_rider.dart';
import 'package:mobile_laundry/widgets/normal_appbar.dart';

class SelectedOrderDetailsPage extends StatefulWidget {
  RiderOrder? order;
  String? address;
  SelectedOrderDetailsPage({
    Key? key,
    this.order,
    this.address,
  }) : super(key: key);

  @override
  State<SelectedOrderDetailsPage> createState() => _SelectedOrderDetailsPageState();
}

class _SelectedOrderDetailsPageState extends State<SelectedOrderDetailsPage> {
  OrdersController ordersController = Get.find<OrdersController>();
  String dobiAddress = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDobiLocation();
  }

  getDobiLocation() async {
    ordersController.coordinatesToAddress(lat: widget.order?.dobiLat, long: widget.order?.dobiLong).then((value) {
      setState(() {
        log(value);
        dobiAddress = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar(title: '${widget.order?.user?.name} Order' ?? 'Order', isCenter: false),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 15,
                  child: ListTile(
                    onTap: () {
                      log('pickUp');
                      MapsLauncher.launchCoordinates(widget.order!.pickupLat!, widget.order!.pickupLong!, 'PickUp');
                    },
                    leading: const Icon(Icons.location_on),
                    title: Text(widget.address ?? ''),
                  ),
                ),
              ),
              RotatedBox(
                quarterTurns: 4,
                // child: Text('---------->'),
                child: Column(
                  children: List.generate(
                      4,
                      (index) => const Icon(
                            Icons.circle,
                            size: 15,
                          )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: dobiAddress == ''
                    ? const SizedBox(height: 30, width: 30, child: CircularProgressIndicator())
                    : Card(
                        elevation: 15,
                        child: ListTile(
                          onTap: () {
                            log('Dobi');
                            MapsLauncher.launchCoordinates(
                              widget.order!.dobiLat!,
                              widget.order!.dobiLong!,
                            );
                          },
                          leading: const Icon(Icons.factory),
                          title: Text(dobiAddress),
                        ),
                      ),
              ),
              RotatedBox(
                quarterTurns: 4,
                child: Column(
                  children: List.generate(
                      4,
                      (index) => const Icon(
                            Icons.circle,
                            size: 15,
                          )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 15,
                  child: ListTile(
                    onTap: () {
                      log('DropOff');
                      MapsLauncher.launchCoordinates(widget.order!.pickupLat!, widget.order!.pickupLong!, 'Delivery');
                    },
                    leading: const Icon(Icons.home),
                    title: Text(widget.address ?? ''),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(thickness: 0.3, color: Colors.black),
              )
            ],
          ),
     
     
     
     
          Container(
            padding: const EdgeInsets.all(8.0),
            height: 100,
            child: Card(
              elevation: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('You will earn '),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.monetization_on_outlined, color: Colors.green),
                      Text('RM ${widget.order?.totalFee?.toStringAsFixed(2)}'),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomBarRider(
                            page: 1,
                            id: widget.order?.id,
                          )),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Accept Order'),
            ),
          )
        ],
      ),
    );
  }
}
