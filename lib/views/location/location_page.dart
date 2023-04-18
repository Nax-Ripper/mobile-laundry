// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:get/get.dart';

import 'package:mobile_laundry/controllers/geo_location_controller.dart';
import 'package:mobile_laundry/widgets/google_maps.dart';

import '../../widgets/location_serach_bar.dart';

class LocationPage extends StatelessWidget {
  String? title;
  int? index;
  LocationPage({
    Key? key,
    this.title,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeoLocationController>(
      init: GeoLocationController(),
      autoRemove: false,
      builder: (ctrl) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Location'),
            ),
            body: Stack(
              children: [
                ctrl.isCurrentLocationLoading.value == true
                    ? Center(child: CircularProgressIndicator())
                    : Obx(
                        () => Gmap(
                          latitude: ctrl.Latitude.value,
                          longitude: ctrl.Longitude.value,
                          listOfLats: ctrl.latslongs,
                        ),
                      ),
                Positioned(
                  left: 20,
                  right: 20,
                  child: Column(
                    children: [
                      LocationSearchBar(
                        // hintText: 'Pickup Address',
                        hintText: title,
                        fieldNumber: index,
                      ),
                      // LocationSearchBar(
                      //   isEnabled: false,
                      // ),
                      // LocationSearchBar(
                      //   hintText: 'Delivery address',
                      // ),
                      // Container(
                      //   margin: EdgeInsets.all(8),
                      //   height: 300,
                      //   color: ctrl.autpCompletePlaces.isNotEmpty ? Colors.black.withOpacity(0.6) : Colors.transparent,
                      //   child: ListView.builder(
                      //     itemCount: ctrl.autpCompletePlaces.length,
                      //     itemBuilder: (context, index) {
                      //       return ListTile(
                      //         title: Text(
                      //           ctrl.autpCompletePlaces[index].description,
                      //           style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                      //         ),
                      //         onTap: () {
                      //           ctrl.getPlace(placeId: ctrl.autpCompletePlaces[index].placeId);
                      //           // log('tag :${Get.find<>()}')

                      //           log('latitude : ${ctrl.Latitude.value}');
                      //           log('longitude : ${ctrl.Longitude.value}');
                      //           //         if (kDebugMode) {
                      //           //           log(''' latitude: ${ctrl.Latitude.value},
                      //           // longitude: ${ctrl.Longitude.value},''');

                      //           //         }

                      //           ctrl.Latitude.value = ctrl.place.latitude ?? ctrl.Latitude.value;
                      //           ctrl.Longitude.value = ctrl.place.longitude ?? ctrl.Longitude.value;
                      //           ctrl.autpCompletePlaces = [];
                      //           ctrl.update();
                      //         },
                      //       );
                      //     },
                      //   ),
                      // )
                    ],
                  ),
                ),

                // Positioned(
                //   top: 70,
                //   left: 20,
                //   right: 20,
                //   child: Column(
                //     children: [
                //       LocationSearchBar(hintText: 'Pickup Address'),
                //     ],
                //   ),
                // ),
                // Positioned(
                //   top: 140,
                //   left: 20,
                //   right: 20,
                //   child: Column(
                //     children: [
                //       LocationSearchBar(
                //         hintText: 'Delivery Address',
                //       ),
                //     ],
                //   ),
                // ),

                Positioned(
                  bottom: 50,
                  left: 20,
                  right: 20,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor.withOpacity(1),
                      ),
                      onPressed: () async {
                        // call geoCode
                        // ctrl.address1 = await ctrl.geoCode.reverseGeocoding(latitude: ctrl.latslongs[0].latitude, longitude: ctrl.latslongs[0].longitude);
                        // Future.delayed(Duration(seconds: 1));
                        // ctrl.address2 = await ctrl.geoCode.reverseGeocoding(latitude: ctrl.latslongs[0].latitude, longitude: ctrl.latslongs[0].longitude);

                        ctrl.update();
                        // convert latlong and update address(str)
                      },
                      child: Text(
                        'Save',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ));
      },
    );
  }
}
