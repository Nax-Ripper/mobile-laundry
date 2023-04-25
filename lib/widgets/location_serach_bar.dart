// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mobile_laundry/controllers/geo_location_controller.dart';

class LocationSearchBar extends StatefulWidget {
  String? hintText;
  bool isEnabled;
  int? fieldNumber;
  // Function onTap;
  // GlobalKey<FormState> formKey;

  LocationSearchBar({
    Key? key,
    this.hintText,
    this.isEnabled = true,
    this.fieldNumber,
  }) : super(key: key);

  @override
  State<LocationSearchBar> createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  GeoLocationController ctrl = Get.find<GeoLocationController>();

  @override
  void initState() {
    super.initState();
    ctrl.autpCompletePlaces.clear();
    ctrl.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeoLocationController>(
      // init: GeoLocationController(),
      init: ctrl,
      // tag: hintText,
      // autoRemove: false,
      builder: (ctrl) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Form(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: ctrl.isCurrentLocationLoading.value
                        ? 'Loading...'
                        : widget.hintText ?? 'Enter your Location',
                    suffixIcon: Icon(
                      Icons.search_rounded,
                    ),
                    enabled: !ctrl.isCurrentLocationLoading.value &&
                        widget.isEnabled,
                  ),
                  onChanged: (value) => {
                    ctrl.getAutoComplete(
                      input: value,
                    ),
                  },
                ),
              ),
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
                        log(widget.hintText ?? '');
                        ctrl.getPlace(
                            placeId: ctrl.autpCompletePlaces[index].placeId);
                        // log('tag :${Get.find<>()}')

                        if (widget.fieldNumber == 1) {
                          log('index: 1');

                          // ctrl.latslongs[0].latitude = ctrl.Latitude.value;
                          ctrl.latslongs[0].latitude = ctrl.Latitude.value;
                          ctrl.latslongs[0].longitude = ctrl.Longitude.value;
                          log('index 1 :${ctrl.latslongs[0].latitude}');

                          ctrl.update();
                        }
                        if (widget.fieldNumber == 2) {
                          log('index: 2');
                          ctrl.latslongs[1].latitude = ctrl.Latitude.value;
                          ctrl.latslongs[1].longitude = ctrl.Longitude.value;

                          log('index 2 :${ctrl.latslongs[1].latitude}');
                        }

                        log('latitude : ${ctrl.Latitude.value}');
                        log('longitude : ${ctrl.Longitude.value}');

                        // ctrl.Latitude.value = ctrl.place.latitude ?? ctrl.Latitude.value;
                        // ctrl.Longitude.value = ctrl.place.longitude ?? ctrl.Longitude.value;
                        ctrl.autpCompletePlaces = [];
                        ctrl.update();
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
