// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/auth_controller.dart';
import 'package:mobile_laundry/controllers/geo_location_controller.dart';
import 'package:mobile_laundry/controllers/order_list_controller.dart';
import 'package:mobile_laundry/controllers/shedule_pickup_controller.dart';
import 'package:mobile_laundry/models/orders_model.dart';
import 'package:mobile_laundry/models/product_model.dart';
import 'package:mobile_laundry/widgets/bottom_bar_customer.dart';

import 'package:http/http.dart' as http;

class OrderDetailsController extends GetxController {
  OrderListController orderListCtrl = Get.find<OrderListController>();
  SheduleController sheduleCtrl = Get.find<SheduleController>();
  AuthController auth = Get.find<AuthController>();
  GeoLocationController geoLocation = Get.find<GeoLocationController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMenuList();
    getSelectedSerivce();
    getSubTotal();
    getRiderFee();
    getTotal();
    getSelectedItemsInfo();
    getUserLocation();
  }

  double subTotal = 0.0;
  int riderFee = 0;
  String selectedSerivce = "";
  List<Product> products = [];
  double Total = 0.0;
  String? intendId;
  String SelectedServiceId = "";
  bool isLoading = false;
  double lat = 0.0;
  double long = 0.0;

  Orders order = Orders();

  static final _auth = LocalAuthentication();

  Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if(!isAvailable) return false;
   log(await _auth.getAvailableBiometrics().then((value) => value.toString() ));
   try {
      return await _auth.authenticate(
        localizedReason: 'Scan Fingerprint to checkout ',
        options:const AuthenticationOptions(
          stickyAuth: true,
          useErrorDialogs: true,
        ));
   } on PlatformException catch (e) {
     log(e.toString());
     return false;
   }
  }

  Future<bool> hasBiometrics() async{
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      log(e.toString());
      return false;
    }
  }

  void getMenuList() {
    log('${orderListCtrl.products[0].name}');
    log('${orderListCtrl.products[0].quantity}');
    log('${orderListCtrl.products[0].price}');
  }

  String getSelectedSerivce() {
    String? selectedSerivce = '';

    for (var service in orderListCtrl.servicesList.service!) {
      if (service.isSelected == true) {
        log(service.name! + ' is selected');
        selectedSerivce = service.name;
        // SelectedServiceId = service.id ?? 'empty';
      }
      update();
    }
    return selectedSerivce ?? '';
  }

  void getSubTotal() {
    subTotal = orderListCtrl.totalAmount.value;
    update();
  }

  void getRiderFee() {
    riderFee = sheduleCtrl.riderFee.value;
    update();
  }

  double getTotal() {
    double total = 0.0;
    total = subTotal + riderFee + orderListCtrl.selectedService.price!;
    Total = total.toPrecision(2);
    update();
    return total;
  }

  void getSelectedItemsInfo() {
    List<Product> selectedItems = [];

    for (var items in orderListCtrl.products) {
      if (items.quantity! > 0) {
        selectedItems.add(items);
      }
    }

    products = selectedItems;

    log('selected items  $selectedItems');
  }

  String currentDateTime() {
    DateTime now = DateTime.now();

    String formattedDate = '';

    return formattedDate =
        '${DateFormat.jm().format(now)} ${DateFormat.yMEd().format(now)}';
  }

  String calculateAmount(String amount) {
    log('Amount $amount');

    double value = double.parse(amount);
    int intValue = (value * 100).toInt();
    String result = intValue.toString();
    log('amountString $result');
    return result;
  }

  displayPayment(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        CherryToast.success(title: Text('Payment Success!')).show(context);
        // make paymentIntent = null
      }).onError((error, stackTrace) {
        log('Error---> $error $stackTrace');
      });
    } on StripeException catch (e) {
      log('Payment Exception :${e.toString()}');
      CherryToast.error(title: Text('Payment Cancelled, Try again '))
          .show(context);
    } catch (e) {
      log(e.toString());
    }
  }

  createPaymentIntent({required String amount, String currency = 'myr'}) async {
    try {
      var body = {
        'amount': calculateAmount(amount),
        // 'amount': '1230',
        'currency': currency,
        'payment_method_types[]': 'card',
        // 'payment_method_types': ['card']
        // 'automatic_payment_methods{}': 'enabled:true',
      };

      var res = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization':
              'Bearer sk_test_51MyH5pAjrQIbGFrMXRC9mUVULcUgOYuPvLW9xS4hQP1y5akqzRSY6x0Xkd5MmPWGR9gNYvcETBlHlpkNzO2BB4Fw00GTDLPaNZ'
        },
      );

      log('Payment Intend res : ${res.body}');
      return jsonDecode(res.body);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Position> getUserLocation() async {
    Position location = await geoLocation.getCurrentLocation();
    lat = location.latitude;
    long = location.longitude;
    return location;
  }

  makePayment(BuildContext context) async {
    if(await authenticate()){
      try {
      var paymentIntent =
          await createPaymentIntent(amount: Total.toString(), currency: 'myr');

      log("client Secret ===>${jsonDecode(jsonEncode(paymentIntent))['client_secret']}");

      intendId = jsonDecode(jsonEncode(paymentIntent))['id'];

      // create payment sheet
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              customFlow: true,
              merchantDisplayName: 'Flutter Stripe Store Demo',
              paymentIntentClientSecret:
                  jsonDecode(jsonEncode(paymentIntent))['client_secret'],
              style: ThemeMode.system,
            ),
          )
          .onError((error, stackTrace) =>
              log(' Error on init : $error $stackTrace'));

      try {
        await Stripe.instance.presentPaymentSheet().then((value) async {
          await Stripe.instance.confirmPaymentSheetPayment().then((value) =>
              CherryToast.success(title: const Text('Payment Success!'))
                  .show(context));

          order = Orders(
            pickUpTime: sheduleCtrl.pickUpTime.value,
            deliveryTime: sheduleCtrl.deliveryTime.value,
            products: products,
            intendId: intendId,
            serviceFee: orderListCtrl.selectedService.price,
            serviceId: orderListCtrl.selectedService.id,
            subTotal: subTotal,
            totalFee: getTotal(),
            userId: auth.user.id,
            riderFee: riderFee,
            pickupLat: lat,
            pickupLong: long,
            deliveryLat: lat,
            deliveryLong: long,
          );
          // paymentIntent = null;
          await addOrder();

          Get.delete<OrderListController>(force: true);
          Get.delete<SheduleController>(force: true);
          Get.delete<OrderDetailsController>(force: true);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomBarCustomer()),
            (Route<dynamic> route) => false,
          );
          CherryToast.success(title: const Text('Payment Success!'))
              .show(context);

          // Navigator.popUntil(context, ModalRoute.withName('/'));
          paymentIntent = null;
        }).onError((LocalizedErrorMessage error, stackTrace) {
          log('Error---> $error $stackTrace');
          CherryToast.error(title: Text('${error.localizedMessage}'))
              .show(context);
        });
      } on StripeException catch (e) {
        log('Payment Exception :${e.toString()}');
        CherryToast.error(title: const Text('Payment Cancelled, Try again '))
            .show(context);
      } catch (e) {
        log(e.toString());
      }
    } catch (e) {
      log(e.toString());
    }
    }else{
      CherryToast.error(title: Text('Authentication Failed')).show(context);
    }
    
  }

  addOrder() async {
    http.Response res = await http.post(
      Uri.parse('$uri/api/place-order'),
      body: order.toJson(),
      // {
      // "serviceId": order.serviceId.toString(),
      // "products": order.products,
      // "subTotal": order.subTotal,
      // "riderFee": order.riderFee,
      // "serviceFee": order.serviceFee,
      // "totalFee": order.totalFee,
      // "userId": order.userId,
      // "intendtId": order.intendId,
      // }.toString(),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'x-auth-token': auth.user.token,
      },
    );

    log('${res.body}');
  }
}
