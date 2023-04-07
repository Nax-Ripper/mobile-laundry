import 'dart:convert';

class LocationLatLong {
  double? latitude;
  double? longitude;
  LocationLatLong({
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory LocationLatLong.fromMap(Map<String, dynamic> map) {
    return LocationLatLong(
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationLatLong.fromJson(String source) => LocationLatLong.fromMap(json.decode(source));
}

class ListofLocationLatLong {
  final List<LocationLatLong> listLaLong;

  ListofLocationLatLong(this.listLaLong);

  Map<String, dynamic> toMap() {
    return {
      'listLaLong': listLaLong.map((x) => x.toMap()).toList(),
    };
  }

  factory ListofLocationLatLong.fromMap(Map<String, dynamic> map) {
    return ListofLocationLatLong(
      List<LocationLatLong>.from(map['listLaLong']?.map((x) => LocationLatLong.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ListofLocationLatLong.fromJson(String source) => ListofLocationLatLong.fromMap(json.decode(source));
}
