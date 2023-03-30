import 'dart:convert';

class Place {
  String? placeId;
  String? name;
  double? latitude;
  double? longitude;
  Place({
     this.placeId= '',
     this.name= '',
     this.latitude,
     this.longitude,
  });

  Place copyWith({
    String? placeId,
    String? name,
    double? latitude,
    double? longitude,
  }) {
    return Place(
      placeId: placeId ?? this.placeId,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'placeId': placeId,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      placeId: map['place_id'] ?? '',
      name: map['formatted_address'] ?? '',
      latitude: map['geometry']['location']['lat']?.toDouble() ?? 0.0,
      longitude: map['geometry']['location']['lng']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) => Place.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Place(placeId: $placeId, name: $name, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Place &&
      other.placeId == placeId &&
      other.name == name &&
      other.latitude == latitude &&
      other.longitude == longitude;
  }

  @override
  int get hashCode {
    return placeId.hashCode ^
      name.hashCode ^
      latitude.hashCode ^
      longitude.hashCode;
  }
}
