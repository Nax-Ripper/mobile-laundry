// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/controllers/geo_location_controller.dart';
import 'package:mobile_laundry/widgets/google_maps.dart';

import '../../widgets/location_serach_bar.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<GeoLocationController>(
        init: GeoLocationController(),
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
                          ),
                        ),
                  Positioned(
                    left: 20,
                    right: 20,
                    child: Column(
                      children: [
                        LocationSearchBar(),
                        Container(
                          margin: EdgeInsets.all(8),
                          height: 300,
                          color: ctrl.autpCompletePlaces.isNotEmpty
                              ? Colors.black.withOpacity(0.6)
                              : Colors.transparent,
                          child: ListView.builder(
                            itemCount: ctrl.autpCompletePlaces.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  ctrl.autpCompletePlaces[index].description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(color: Colors.white),
                                ),
                                onTap: () {
                                  ctrl.getPlace(
                                      placeId: ctrl
                                          .autpCompletePlaces[index].placeId);
                                  if (kDebugMode) {
                                    print(''' latitude: ${ctrl.Latitude.value},
                          longitude: ${ctrl.Longitude.value},''');
                                  }

                                  ctrl.Latitude.value = ctrl.place.latitude ??
                                      ctrl.Latitude.value;
                                  ctrl.Longitude.value = ctrl.place.longitude ??
                                      ctrl.Longitude.value;
                                  ctrl.autpCompletePlaces = [];
                                  ctrl.update();
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 20,
                    right: 20,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).primaryColor.withOpacity(1),
                        ),
                        onPressed: () => {},
                        child: Text(
                          'Save',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }
}
