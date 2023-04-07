// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Gmap extends StatelessWidget {
  final double latitude;
  final double longitude;
  Gmap({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Marker _pickUP = Marker(
      markerId: MarkerId('_pickUP'),
      infoWindow: InfoWindow(title: 'My House'),
      icon: BitmapDescriptor.defaultMarker,
      // position: LatLng(latitude, longitude),
      position: LatLng(2.4978472567790244, 102.85496296940443),
    );

    final Marker _dobiIOI = Marker(
      markerId: MarkerId('_dobiIOI'),
      infoWindow: InfoWindow(title: 'DobiIOI'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: LatLng(2.499571073897077, 102.85764956066805),
    );

    final Marker _delivery = Marker(
      markerId: MarkerId('_delivery'),
      infoWindow: InfoWindow(title: 'Delivery'),
      icon: BitmapDescriptor.defaultMarker,
      // position: LatLng(latitude, longitude),
      position: LatLng(2.495510157382259, 102.85371210727995),
    );

    final Polyline _kPolyline = Polyline(
        polylineId: PolylineId('_kPolylines'),
        points: [
          LatLng(2.4978472567790244, 102.85496296940443),
          LatLng(2.499571073897077, 102.85764956066805),
          LatLng(2.495510157382259, 102.85371210727995),
        ],
        width: 3,
        jointType: JointType.round,
        color: Colors.red);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: GoogleMap(
        // mapType: MapType.hybrid,
        polylines: {_kPolyline},
        markers: {_pickUP, _dobiIOI, _delivery},
        myLocationButtonEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 10,
        ),
      ),
    );
  }
}
