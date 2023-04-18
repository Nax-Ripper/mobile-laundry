// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mobile_laundry/controllers/geo_location_controller.dart';
import 'package:mobile_laundry/models/location_lat_long.dart';

class Gmap extends StatefulWidget {
  final double latitude;
  final double longitude;
  final List<LocationLatLong>? listOfLats;
  Gmap({
    Key? key,
    required this.latitude,
    required this.longitude,
    this.listOfLats,
  }) : super(key: key);

  @override
  State<Gmap> createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  @override
  Widget build(BuildContext context) {
   
    GeoLocationController locator = Get.find<GeoLocationController>();

    return GetBuilder(
      init: locator,
      builder: (ctrl) {
        log('lat : ${ctrl.latslongs[0].latitude}');
        log('long : ${ctrl.latslongs[0].longitude}');

        Marker _pickUP = Marker(
          markerId: MarkerId('_pickUP'),
          infoWindow: InfoWindow(title: 'Pick UP'),
          icon: BitmapDescriptor.defaultMarker,
          // position: LatLng(latitude, longitude),
          // position: LatLng(ctrl.latslongs[0].latitude ?? 0, ctrl.latslongs[0].longitude ?? 0),
          position: LatLng(widget.listOfLats![0].latitude, widget.listOfLats![0].longitude),
          // position: LatLng(widget.latitude, widget.longitude),
        );

        Marker _dobiIOI = Marker(
          markerId: MarkerId('_dobiIOI'),
          infoWindow: InfoWindow(title: 'DobiIOI'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          position: LatLng(2.499571073897077, 102.85764956066805),
        );

        Marker _delivery = Marker(
          markerId: MarkerId('_delivery'),
          infoWindow: InfoWindow(title: 'Delivery'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          // position: LatLng(latitude, longitude),
          position: LatLng(widget.listOfLats![1].latitude, widget.listOfLats![1].longitude),
        );

        Polyline _kPolyline = Polyline(
            polylineId: PolylineId('_kPolylines'),
            points: [
              // LatLng(2.4978472567790244, 102.85496296940443),
              // LatLng(2.499571073897077, 102.85764956066805),
              // LatLng(2.495510157382259, 102.85371210727995),
              LatLng(widget.listOfLats![0].latitude, widget.listOfLats![0].longitude),
              LatLng(2.499571073897077, 102.85764956066805),
              LatLng(widget.listOfLats![1].latitude, widget.listOfLats![1].longitude),
            ],
            width: 3,
            jointType: JointType.round,
            color: Colors.red);
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: GoogleMap(
            // mapType: MapType.hybrid,
            // polylines: {ctrl.kPolyline},
            polylines: {_kPolyline},
            // markers: {ctrl.pickUP, ctrl.dobiIOI, ctrl.delivery},
            markers: {_pickUP, _dobiIOI, _delivery},
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(
              // target: LatLng(widget.latitude, widget.longitude),
              target: LatLng(widget.listOfLats![0].latitude, widget.listOfLats![0].longitude),
              zoom: 12,
            ),
          ),
        );
      },
    );
  }
}
