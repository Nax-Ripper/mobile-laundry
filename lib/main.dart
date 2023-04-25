import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:mobile_laundry/config/theme.dart';
import 'package:mobile_laundry/controllers/auth_controller.dart';
import 'package:mobile_laundry/routes/router.dart';
import 'package:mobile_laundry/views/admin/admin_home_page.dart';
import 'package:mobile_laundry/views/auth/auth_page.dart';
import 'package:mobile_laundry/widgets/bottom_bar_customer.dart';
import 'package:mobile_laundry/widgets/bottom_bar_rider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51MyH5pAjrQIbGFrMLIS4WYyUDtJ3qKxwLWIHlfhRvmUleTSQ8cgyqWHSTOZp0xIgSlloHMmzUrKv25mqbYeAq7I600QWkMiNaJ';
  Stripe.merchantIdentifier = 'any string works';
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AuthController getX = Get.put(AuthController(), permanent: true);
    @override
    void initState() {
      super.initState();
      getX = Get.find<AuthController>().initialized
          ? Get.find<AuthController>()
          : Get.put(AuthController());
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: theme(),

      onGenerateRoute: (settings) => generateRoute(settings),

      // initialRoute: RouteName.homePage,
      // initialRoute: RouteName.homePage,
      // home: OrderDetailsPage(),
      // home:Get.find<AuthController>().initialized!= true Get.put(AuthController()).getUser.isEmpty? AuthPage():Get.find<AuthController>().getUser.type=='user'?BottomBar():AdminHomePage() ,
      // home: getX.user.token.isEmpty
      //     ? const AuthPage()
      //     : getX.user.type == 'user'
      //         ? BottomBarCustomer()
      //         : const AdminHomePage(),
      home: BottomBarRider(),
    );
  }
}
