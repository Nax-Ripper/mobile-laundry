import 'package:flutter/material.dart';
import 'package:mobile_laundry/config/theme.dart';
import 'package:mobile_laundry/routes/route_name.dart';
import 'package:mobile_laundry/routes/router.dart';
import 'package:mobile_laundry/views/home/home_page.dart';
import 'package:mobile_laundry/widgets/bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      onGenerateRoute: (settings) => generateRoute(settings),
      // initialRoute: RouteName.homePage,
      // initialRoute: RouteName.homePage,
      home: BottomBar(),
    );
  }
}
