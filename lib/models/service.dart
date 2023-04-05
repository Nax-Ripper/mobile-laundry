import 'dart:convert';

class Service {
  String? id;
  String? name;
  String? description;
  String? imageUrl;
  int? v;
  bool? isSelected;

  Service({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.v,
    this.isSelected,
  });

  factory Service.fromMap(Map<String, dynamic> data) => Service(
      id: data['_id'] as String?,
      name: data['name'] as String?,
      description: data['description'] as String?,
      imageUrl: data['imageUrl'] as String?,
      v: data['__v'] as int?,
      isSelected: data['isSelected'] as bool?);

  Map<String, dynamic> toMap() => {'_id': id, 'name': name, 'description': description, 'imageUrl': imageUrl, '__v': v, 'isSelected': isSelected};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Service].
  factory Service.fromJson(String data) {
    return Service.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Service] to a JSON string.
  String toJson() => json.encode(toMap());
}

class Services {
  List<Service>? service;

  Services({this.service});

  factory Services.fromMap(Map<String, dynamic> data) => Services(
        service: (data['service'] as List<dynamic>?)?.map((e) => Service.fromMap(e as Map<String, dynamic>)).toList(),
      );

  Map<String, dynamic> toMap() => {
        'service': service?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Services].
  factory Services.fromJson(String data) {
    return Services.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Services] to a JSON string.
  String toJson() => json.encode(toMap());
}
