import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:mobile_laundry/config/global_variables.dart';
import 'package:mobile_laundry/controllers/geo_location_controller.dart';
import 'package:mobile_laundry/widgets/bottom_bar_customer.dart';

class CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  GeoLocationController? locator;
  CustomAppbar({
    Key? key,
    this.locator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // GeoLocationController locator = Get.find<GeoLocationController>();

    return AppBar(
      leading: IconButton(
        onPressed: () {
          BottomBarCustomer(page: 2,);
        },
        icon: Icon(
          Icons.person,
        ),
      ),
      title: GetBuilder(
        init: locator,
        builder: (locator) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text('CURRENT LOCATION',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 17)),
              locator.places.isEmpty
                  ? LoadingAnimationWidget.waveDots(
                      color: GlobalVariables.primaryColor, size: 30)
                  : Text(
                      '${locator.places[2].name} , ${locator.places[2].locality}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 16)),
            ],
          );
        },
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}
