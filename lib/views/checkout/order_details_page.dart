// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/order_details_controller.dart';
import 'package:mobile_laundry/widgets/normal_appbar.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailsController>(
      init: OrderDetailsController(),
      builder: (ctrl) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: NormalAppBar(title: 'Order Detail', isCenter: false),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Material(
                    color: Colors.white,
                    child: SvgPicture.asset(
                      'lib/assets/checkout_pic.svg',
                      clipBehavior: Clip.none,
                    ),
                  ),
                ),
                Text('Thanks for choosing Us!'),
                // Text('Your pickup has been confirmed'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    height: 500,
                    // constraints: BoxConstraints(maxHeight: 1500, minHeight: 400),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: GlobalVariables.greyColor),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          // title: Text('Order #123'),
                          // subtitle: Text('11:35,Thu,15 Jun 2019'),
                          subtitle: Text('${ctrl.currentDateTime()}'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                // child: Text('Wash & Dry'),
                                child: Text(ctrl.getSelectedSerivce()),
                              ),
                              SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: ctrl.products.length,
                                  itemBuilder: (context, i) {
                                    return Card(
                                      child: ListTile(
                                        dense: true,
                                        title: Text(ctrl.products[i].name!),
                                        subtitle: Text('Quantity: ${ctrl.products[i].quantity}'),
                                        trailing: Text('RM ${double.parse((ctrl.products[i].quantity! * ctrl.products[i].price!).toStringAsFixed(2))}'),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('SubTotal'),
                          trailing: Text('RM ${double.parse((ctrl.subTotal).toStringAsFixed(2))}'),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Rider Fee'),
                          trailing: Text('RM ${ctrl.riderFee}'),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Service Fee'),
                          trailing: Text('RM ${ctrl.orderListCtrl.selectedService.price}'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Total'),
                          trailing: Text('RM ${ctrl.getTotal()}'),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 300,
                            child: Center(child: Text('Hello')),
                          );
                        },
                      );
                    },
                    child: Text('Place Order!'),
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
