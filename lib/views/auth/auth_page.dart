import 'dart:convert';
import 'dart:developer';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/auth_controller.dart';
import 'package:mobile_laundry/models/users_model.dart';
import 'package:mobile_laundry/routes/route_name.dart';
import 'package:mobile_laundry/views/admin/admin_home_page.dart';
import 'package:mobile_laundry/views/home/home_page.dart';
import 'package:mobile_laundry/widgets/bottom_bar_customer.dart';
import 'package:http/http.dart' as http;

import '../../utils/http_handler.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (ctrl) {
        return FlutterLogin(
          title: 'LAUNDRYFY',
          onLogin: (data) async {
            ctrl.user.email = data.name;
            ctrl.user.password = data.password;

            http.Response res = await http.post(
              Uri.parse('$uri/api/signin'),
              body: ctrl.user.toJson(),
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
            );

            log('User:${ctrl.user.toJson()}');
            if (res.statusCode == 400) {
              return jsonDecode(res.body)['msg'];
            }
            log(res.body);
            if (res.statusCode == 200) {
              ctrl.user = User.fromJson(res.body);
            }
            ctrl.update();

            return null;
          },
          onSignup: (data) async {
            ctrl.user.email = data.name!;
            ctrl.user.password = data.password!;
            ctrl.user.name = data.additionalSignupData!['Username']!;

            http.Response res = await http.post(
              Uri.parse('$uri/api/signup'),
              body: ctrl.user.toJson(),
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
            );

            if (res.statusCode == 400) {
              return jsonDecode(res.body)['msg'];
            }
            if (res.statusCode == 200) {
              ctrl.user = User.fromJson(res.body);
              log(ctrl.user.phoneNumber);
              ctrl.update();
            }

            log('userName: ${ctrl.user.name}');
            return null;
          },
          messages: LoginMessages(
            signUpSuccess: 'Welcome user}',
            confirmSignupIntro: 'Welcome${ctrl.user.name}.',
          ),
          additionalSignupFields: [
            const UserFormField(
              keyName: 'Username',
              icon: Icon(Icons.abc),
            ),
            UserFormField(
              keyName: 'phone_number',
              displayName: 'Phone Number',
              userType: LoginUserType.phone,
              fieldValidator: (value) {
                final phoneRegExp = RegExp(
                  '^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}\$',
                );
                if (value != null && value.length < 7 && !phoneRegExp.hasMatch(value)) {
                  return "This isn't a valid phone number";
                }
                return null;
              },
            ),
          ],
          onRecoverPassword: (p0) {},
          onSubmitAnimationCompleted: () {
            if (ctrl.user.type == 'admin') {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => AdminHomePage(),
              ));
            } else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => BottomBarCustomer(),
              ));
            }
          },
        );
      },
    );
  }
}
