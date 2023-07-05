import 'dart:convert';

class Riders {
  
  String? name;
  String? email;
  // String? passowrd;
  String? icURL;
  String? lisenceURL;
  String? phone;
  String? id;
  bool? approved;
  String? pdf;
  String? type;
  Riders({
    this.name,
    this.email,
    this.icURL,
    this.lisenceURL,
    this.phone,
    this.id,
    this.approved,
    this.pdf,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'icURL': icURL,
      'lisenceURL': lisenceURL,
      'phone': phone,
      // 'id': id,
      'approved': approved,
      'pdf': pdf,
      'type': type,
    };
  }

  factory Riders.fromMap(Map<String, dynamic> map) {
    return Riders(
      name: map['name'],
      email: map['email'],
      icURL: map['imagesIc'],
      lisenceURL: map['imageLisence'],
      phone: map['phoneNumber'],
      id: map['_id'],
      approved: map['approved'],
      pdf: map['pdf'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Riders.fromJson(String source) => Riders.fromMap(json.decode(source));
}

class RidersList {
  List<Riders>? riders = [];
  RidersList({
    this.riders,
  });

  Map<String, dynamic> toMap() {
    return {
      'riders': riders?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory RidersList.fromMap(Map<String, dynamic> map) {
    return RidersList(
      riders: map['riders'] != null ? List<Riders>.from(map['riders']?.map((x) => Riders.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RidersList.fromJson(String source) => RidersList.fromMap(json.decode(source));
}
