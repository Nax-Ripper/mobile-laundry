import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/controllers/auth_controller.dart';
import 'package:mobile_laundry/controllers/home_controller.dart';
import 'package:mobile_laundry/controllers/order_details_controller.dart';
import 'package:mobile_laundry/controllers/order_list_controller.dart';
import 'package:mobile_laundry/controllers/rider_controller/rider_signup_controller.dart';
import 'package:mobile_laundry/controllers/shedule_pickup_controller.dart';
import 'package:mobile_laundry/views/auth/auth_page.dart';

class RiderProfilePage extends StatelessWidget {
  Widget textfield({@required hintText}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            fillColor: Colors.white30,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  log('lgout');
                 Get.deleteAll();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => AuthPage()),
                    (Route<dynamic> route) => false,
                  );
                },
                icon: Icon(
                  Icons.logout,
                  size: 30,
                ))
          ],
          elevation: 0.0,
          backgroundColor: Color(0xff555555),
        ),
        body: GetBuilder<RiderSignupPageController>(
          init: RiderSignupPageController(),
          builder: (ctrl) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 450,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          textfield(
                            // hintText: 'Username',
                            hintText: ctrl.rider.name,
                          ),
                          textfield(
                            // hintText: 'Email',
                            hintText: ctrl.rider.email,
                          ),
                          SizedBox(),
                          SizedBox(),
                          SizedBox(),
                          // textfield(
                          //   // hintText: 'Address',
                          //   hintText: ctrl.user.address,
                          // ),
                          // textfield(
                          //   // hintText: 'Phone Number',
                          //   hintText: ctrl.user.phoneNumber,
                          // ),
                          // Container(
                          //     decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(15)),
                          //     height: 55,
                          //     width: double.infinity,
                          //     child:
                          //     // IconButton(
                          //     //    onPressed: () {
                          //     //      log('logout');
                          //     //    },
                          //     //     icon: Icon(Icons.power_settings_new_outlined))
                          //      ElevatedButton(
                          //       onPressed: () {
                          //         log('logout');
                          //       },
                          //       child: Center(
                          //         child: Text(
                          //           "Logout",
                          //           style: TextStyle(
                          //             fontSize: 23,
                          //             color: Colors.white,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     )

                          // ElevatedButton(onPressed: () {
                          //   log('logout');

                          // }, child: Text('Logout'))
                        ],
                      ),
                    )
                  ],
                ),
                CustomPaint(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  painter: HeaderCurvedContainer(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Profile",
                        style: TextStyle(
                          fontSize: 35,
                          letterSpacing: 1.5,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 5),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('lib/assets/banner.png'),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 270, left: 184),
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        log('editImage');
                      },
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xff555555);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
