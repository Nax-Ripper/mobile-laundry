// ignore_for_file: unused_field, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_laundry/models/arguments_model.dart';
import 'package:mobile_laundry/models/location_lat_long.dart';
// import 'package:mobile_laundry/models/location_lat_long.dart';
import 'package:mobile_laundry/models/place_autocomplete.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:mobile_laundry/models/place_model.dart';

class GeoLocationController extends GetxController {
  RxBool isCurrentLocationLoading = true.obs;
  RxBool isPlaceLoading = true.obs;
  RxDouble Latitude = 2.50346.obs;
  RxDouble Longitude = 102.8207542.obs;
  late LocationPermission permission;
  List<PlaceAutoComplete> autpCompletePlaces = [];
  Place place = Place();
  late Position pos;
  GeoCode geoCode = GeoCode(apiKey: '772073767714501497030x70515');
  Address address = Address();
  String? FullAddress1;
  String? FullAddress2;
  String? shortAddress1;
  String? shortAddress2;

  // Address address1 = Address();
  // Address address2 = Address();
  // GeoLocationController searchBar1 = Get.find(tag: 'Pickup Address');
  // GeoLocationController searchBar2 = Get.find(tag: 'Delivery Address');
  List<LocationLatLong> latslongs = [
    LocationLatLong(latitude: 2.499571073897077, longitude: 102.85764956066805),
    LocationLatLong(latitude: 2.499571073897077, longitude: 102.85764956066805),
  ];

  List<Placemark> places = [];

  static const String key = 'AIzaSyB1_5TEpfxa-qWY8nc7DnMHeUnV6HQs15U';
  static const String types = 'address';

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<Position> getCurrentLocation() async {
    isCurrentLocationLoading.value = true;
    // Position pos;
    // placemarks.clear();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);

    log('$pos');
    Latitude.value = pos.latitude;
    Longitude.value = pos.longitude;

    // address = await geoCode.reverseGeocoding(latitude: pos.latitude, longitude: pos.longitude);
    // address = await geoCode.reverseGeocoding(latitude: 37.2430117, longitude: -122.1677517);

    places = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    Placemark place = places[2];
    for (var i = 0; i < places.length; i++) {
      // name of jalan
      log('street:${places[2].street}');
      // johor Bahru
      log('locality:${places[2].locality}');
      // log('sublocality:${places[i].subLocality}');
      // Johor
      log('administrativeArea:${places[2].administrativeArea}');
      // Malaysia
      log('country:${places[2].country}');
      // same as jalan
      log('name:${places[2].name}');
      // postal (85000)
      log('postalCode:${places[i].postalCode}');
      // log('subThroughfare:${places[i].subThoroughfare}');
      // log('Throughfare:${places[i].thoroughfare}');
      log('-----------------------------------------');
    }

    log('Full Address : ${place.name} , ${place.locality} , ${place.postalCode}, ${place.administrativeArea}');

    // log('Full address : ${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}');

    // log('The address is ${address.streetAddress}');

    FullAddress1 = await getAddress(lat: pos.latitude, long: pos.longitude, isShort: false);
    shortAddress1 = await getAddress(lat: pos.latitude, long: pos.longitude, isShort: true);
    isCurrentLocationLoading.value = false;
    update();
    refresh();
    return pos;
  }

  Future getAutoComplete({String input = '', int serchbar = 1}) async {
    isPlaceLoading;
    final String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=$types&key=$key';
    // final String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=segamat&types=$types&key=$key';
    var res = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(res.body);
    var result = json['predictions'] as List;
    log('$result');
    isPlaceLoading.value = false;
    autpCompletePlaces = result.map((places) => PlaceAutoComplete.fromMap(places)).toList();
    update();

    log('$autpCompletePlaces');

    // PlaceAutoComplete.fromJson(res.body);
  }

  getAddress({required double lat, required double long, required isShort}) async {
    places = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    Placemark place = places[2];

    if (isShort) {
      return '${place.name} , ${place.locality} , ${place.postalCode} ${place.administrativeArea}';
    } else {
      return '${place.name} , ${place.locality}';
    }
  }

  Future getPlace({required String placeId}) async {
    isCurrentLocationLoading.value = true;
    final String url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var res = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(res.body);
    var result = json['result'] as Map<String, dynamic>;
    place = Place.fromMap(result);
    Latitude.value = place.latitude!;
    Longitude.value = place.longitude!;
    log('lat=${Latitude.value},long=${Longitude.value}');
    isCurrentLocationLoading.value = false;
    // autpCompletePlaces.clear();
    update();
  }
}
