import 'dart:developer';

import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
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
  GeoCode geoCode = GeoCode(apiKey: '772073767714501497030x70515');
  Address address = Address();
  String? FullAddress;

  // GeoLocationController searchBar1 = Get.find(tag: 'Pickup Address');
  // GeoLocationController searchBar2 = Get.find(tag: 'Delivery Address');

  ListofLocationLatLong LatLongs = ListofLocationLatLong([
    LocationLatLong(latitude: 2.499571073897077, longitude: 102.85764956066805),
    LocationLatLong(latitude: 2.499571073897077, longitude: 102.85764956066805),
  ]);

  static const String key = 'AIzaSyB1_5TEpfxa-qWY8nc7DnMHeUnV6HQs15U';
  static const String types = 'geocode';

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<Position> getCurrentLocation() async {
    isCurrentLocationLoading.value = true;
    Position pos;
    // placemarks.clear();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    log('$pos');
    Latitude.value = pos.latitude;
    Longitude.value = pos.longitude;
    address = await geoCode.reverseGeocoding(latitude: pos.latitude, longitude: pos.longitude);
    log('${address.streetAddress}');
    FullAddress = getFullAddress(streetNum: address.streetNumber ?? 0, streetAdd: address.streetAddress!, countryName: address.countryName!, postal: address.postal!, city: address.city!);
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

  getFullAddress({required int streetNum, required String streetAdd, required String countryName, required String postal, required String city}) {
    return '$streetNum ,$streetAdd ,$postal,$city, $countryName ';
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
