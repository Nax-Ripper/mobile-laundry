// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripPayment;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/order_details_controller.dart';
import 'package:mobile_laundry/controllers/order_list_controller.dart';
import 'package:mobile_laundry/widgets/bottom_bar_customer.dart';
import 'package:mobile_laundry/widgets/normal_appbar.dart';
import 'package:http/http.dart' as http;

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  // Map<String, dynamic> paymentIntent;

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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                        subtitle: Text(
                                            'Quantity: ${ctrl.products[i].quantity}'),
                                        trailing: Text(
                                            'RM ${double.parse((ctrl.products[i].quantity! * ctrl.products[i].price!).toStringAsFixed(2))}'),
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
                          trailing: Text(
                              'RM ${double.parse((ctrl.subTotal).toStringAsFixed(2))}'),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Rider Fee'),
                          trailing: Text('RM ${ctrl.riderFee}'),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Service Fee'),
                          trailing: Text(
                              'RM ${ctrl.orderListCtrl.selectedService.price}'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Total'),
                          trailing: Text(
                              'RM ${double.parse(ctrl.getTotal().toString()).toStringAsFixed(2)}'),
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
                      ctrl.makePayment(context);
                      // showModalBottomSheet(
                      //   elevation: 15,
                      //   // backgroundColor: Colors.grey,
                      //   useSafeArea: true,
                      //   context: context,
                      //   builder: (context) {
                      //     return SingleChildScrollView(
                      //       controller: ScrollController(),
                      //       child: Center(
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(20),
                      //           child: Container(
                      //             height: 500,
                      //             child: Column(
                      //               children: [
                      //                 stripeCard.CardFormField(
                      //                   controller: stripeCard.CardFormEditController(),
                      //                   style: stripeCard.CardFormStyle(
                      //                     // borderWidth: 10,
                      //                     // borderColor: Colors.green,
                      //                     borderRadius: 10,
                      //                     textErrorColor: Colors.red,
                      //                     backgroundColor: GlobalVariables.secondaryColor,
                      //                     textColor: Colors.black,
                      //                     placeholderColor: Colors.black,
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   width: MediaQuery.of(context).size.width,
                      //                   child: ElevatedButton(
                      //                     onPressed: () {},
                      //                     child: Text('Pay'),
                      //                   ),
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // );
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

  // displayPayment(BuildContext context) async {
  //   try {
  //     await stripPayment.Stripe.instance.presentPaymentSheet().then((value) {
  //       CherryToast.success(title: Text('Payment Success!')).show(context);
  //       // make paymentIntent = null
  //     }).onError((error, stackTrace) {
  //       log('Error---> $error $stackTrace');
  //     });
  //   } on stripPayment.StripeException catch (e) {
  //     log('Payment Exception :${e.toString()}');
  //     CherryToast.error(title: Text('Payment Cancelled, Try again ')).show(context);
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  // createPaymentIntent({required String amount, String currency = 'usd'}) async {
  //   try {
  //     var body = {
  //       'amount': calculateAmount(amount),
  //       'currency': currency,
  //       'payment_method_types[]': 'card',
  //       // 'payment_method_types': ['card']
  //       // 'automatic_payment_methods{}': 'enabled:true',
  //     };

  //     var res = await http.post(
  //       Uri.parse('https://api.stripe.com/v1/payment_intents'),
  //       body: body,
  //       headers: {
  //         'Content-Type': 'application/x-www-form-urlencoded',
  //         'Authorization': 'Bearer sk_test_51MyH5pAjrQIbGFrMXRC9mUVULcUgOYuPvLW9xS4hQP1y5akqzRSY6x0Xkd5MmPWGR9gNYvcETBlHlpkNzO2BB4Fw00GTDLPaNZ'
  //       },
  //     );

  //     log('Payment Intend res : ${res.body}');
  //     return jsonDecode(res.body);
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  // String calculateAmount(String amount) {
  //   return (int.parse(amount) * 100).toString();
  // }

  // makePayment() async {
  //   try {
  //     var paymentIntent = await createPaymentIntent(amount: '10', currency: 'myr');
  //     setState(() {});

  //     log("client Secret ===>${jsonDecode(jsonEncode(paymentIntent))['client_secret']}");
  //     // create payment sheet
  //     await stripPayment.Stripe.instance
  //         .initPaymentSheet(
  //           paymentSheetParameters: stripPayment.SetupPaymentSheetParameters(
  //             customFlow: true,
  //             merchantDisplayName: 'Flutter Stripe Store Demo',
  //             paymentIntentClientSecret: jsonDecode(jsonEncode(paymentIntent))['client_secret'],
  //             // style: ThemeMode.system,
  //           ),
  //         )
  //         .onError((error, stackTrace) => log(' Error on init : $error $stackTrace'));
  //     setState(() {});

  //     try {
  //       await stripPayment.Stripe.instance.presentPaymentSheet().then((value) async {
  //         await stripPayment.Stripe.instance.confirmPaymentSheetPayment().then((value) => CherryToast.success(title: Text('Payment Success!')).show(context));
  //         paymentIntent = null;
  //         Get.delete<OrderListController>(force: true);
  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (context) => BottomBar()),
  //           (Route<dynamic> route) => false,
  //         );

  //         // Navigator.popUntil(context, ModalRoute.withName('/'));
  //         // make paymentIntent = null
  //       }).onError((stripPayment.LocalizedErrorMessage error, stackTrace) {
  //         log('Error---> $error $stackTrace');
  //         CherryToast.error(title: Text('${error.localizedMessage}')).show(context);
  //       });
  //     } on stripPayment.StripeException catch (e) {
  //       log('Payment Exception :${e.toString()}');
  //       CherryToast.error(title: Text('Payment Cancelled, Try again ')).show(context);
  //     } catch (e) {
  //       log(e.toString());
  //     }

  //     // await stripPayment.Stripe.instance.presentPaymentSheet();

  //     // .then((value) => displayPayment(context),);
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }
}
