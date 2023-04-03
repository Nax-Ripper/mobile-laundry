import 'dart:convert';

class PlaceAutoComplete {
  final String description;
  final String placeId;
  PlaceAutoComplete({
    required this.description,
    required this.placeId,
  });

  PlaceAutoComplete copyWith({
    String? description,
    String? placeId,
  }) {
    return PlaceAutoComplete(
      description: description ?? this.description,
      placeId: placeId ?? this.placeId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'placeId': placeId,
    };
  }

  factory PlaceAutoComplete.fromMap(Map<String, dynamic> map) {
    return PlaceAutoComplete(
      description: map['description'] ?? '',
      placeId: map['place_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceAutoComplete.fromJson(String source) =>
      PlaceAutoComplete.fromMap(json.decode(source));

  @override
  String toString() =>
      'PlaceAutoComplete(description: $description, placeId: $placeId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlaceAutoComplete &&
        other.description == description &&
        other.placeId == placeId;
  }

  @override
  int get hashCode => description.hashCode ^ placeId.hashCode;
}
