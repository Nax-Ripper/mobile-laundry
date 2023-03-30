import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
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

  static const String key = 'AIzaSyB1_5TEpfxa-qWY8nc7DnMHeUnV6HQs15U';
  static const String types = 'geocode';

  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<Position> getCurrentLocation() async {
    isCurrentLocationLoading;
    Position pos;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    log('${pos}');
    Latitude.value = pos.latitude;
    Longitude.value = pos.longitude;
    isCurrentLocationLoading.value = false;
    update();
    return pos;
  }

  Future getAutoComplete({String input = ''}) async {
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
