// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_laundry/controllers/geo_location_controller.dart';
import 'package:mobile_laundry/controllers/home_controller.dart';
import 'package:mobile_laundry/routes/route_name.dart';
import 'package:mobile_laundry/widgets/custom_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // HomeController hCtrl = Get.put(HomeController());
    GeoLocationController locator = Get.find<GeoLocationController>();

    return GetBuilder<HomeController>(
      // init: hCtrl,
      init: HomeController(),
      builder: (hCtrl) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppbar(locator: locator),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: SizedBox(
                    height: 120,
                    child: ListView.builder(
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: hCtrl.servicesList.service?.length ?? 3,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return Card(
                          elevation: 5,
                          child: InkWell(
                            onTap: () {
                              hCtrl.args.index = i;
                              hCtrl.update();
                              log('tap $i');
                              Navigator.pushNamed(
                                context,
                                RouteName.orderListPage,
                                arguments: hCtrl.args,
                              );
                            },
                            child: hCtrl.servicesList.service == null
                                ? SizedBox(
                                    width: 100,
                                    height: 50,
                                    child: CircularProgressIndicator(),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(right: 5),
                                    width: 110,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 10,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                            ),
                                            child: Container(
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.white),
                                              child: Image.network(
                                                  '${hCtrl.servicesList.service![i].imageUrl}'),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(
                                            hCtrl
                                                .servicesList.service![i].name!,
                                            // style: Theme.of(context).textTheme.displaySmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              BookNowBanner(),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'List of Orders',
                  // style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  //       color: Color.fromARGB(255, 31, 102, 159),
                  //       fontSize: 20,
                  //     ),
                ),
              ),
              if (hCtrl.orderList.orders == null)
                Center(
                  child: CircularProgressIndicator(),
                )
              else if (hCtrl.orderList.orders?.length == 0)
                Center(
                  child: Text('No orders found'),
                )
              else
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: hCtrl.orderList.orders?.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          height: 90,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(244, 214, 212, 212)
                                .withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(Icons.local_laundry_service, size: 75),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order #$i',
                                    // style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                    //       color: Theme.of(context).primaryColor,
                                    //     ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              DateFormat.jm().format(hCtrl
                                                      .orderList
                                                      .orders?[i]
                                                      .pickUpTime ??
                                                  DateTime.now()),
                                              // hCtrl.orders[i].startTime,
                                              // style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.black),
                                            ),
                                            Text(
                                              DateFormat.yMd().format(hCtrl
                                                      .orderList
                                                      .orders?[i]
                                                      .pickUpTime ??
                                                  DateTime.now()),
                                              // hCtrl.orders[i].StartDate,
                                              // style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black.withOpacity(0.6)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.circle_outlined,
                                          size: 15,
                                          color: Colors.red,
                                        ),
                                        Text(
                                          '--------',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Icon(
                                          Icons.circle,
                                          size: 15,
                                          color: Colors.green,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              DateFormat.jm().format(hCtrl
                                                      .orderList
                                                      .orders?[i]
                                                      .deliveryTime ??
                                                  DateTime.now()),
                                              // hCtrl.orders[i].endTime,
                                              // style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.black),
                                            ),
                                            Text(
                                              DateFormat.yMd().format(hCtrl
                                                      .orderList
                                                      .orders?[i]
                                                      .pickUpTime ??
                                                  DateTime.now()),
                                              // hCtrl.orders[i].EndDate,
                                              // style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black.withOpacity(0.6)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'RM ${double.parse((hCtrl.orderList.orders?[i].totalFee).toString()).toStringAsFixed(2)}',
                                      // 'RM ${hCtrl.orders[i].amount}',
                                      // style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                      //       color: Color.fromARGB(255, 173, 16, 69),
                                      //     ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('pending')
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}

class BookNowBanner extends StatelessWidget {
  const BookNowBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 120,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color.fromARGB(255, 31, 102, 159),
          ),
          child: Row(
            children: [
              Image.asset(
                'lib/assets/banner.png',
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enjoy hassle-free cleaning with our pickup and delivery service!',
                      // style: Theme.of(context).textTheme.headlineMedium,
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(1),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Book Now',
                        // style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
