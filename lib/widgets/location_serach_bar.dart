// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_laundry/controllers/geo_location_controller.dart';

class LocationSearchBar extends StatelessWidget {
  const LocationSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeoLocationController>(
      init: GeoLocationController(),
      builder: (ctrl) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
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
                  : 'Enter your Location',
              suffixIcon: Icon(
                Icons.search_rounded,
              ),
              enabled: !ctrl.isCurrentLocationLoading.value,
            ),
            onChanged: (value) => {
              ctrl.getAutoComplete(input: value),
            },
          ),
        );
      },
    );
  }
}
