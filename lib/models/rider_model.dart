import 'dart:convert';

class Riders {
  String? name;
  String? email;
  String? passowrd;
  String? icURL;
  String? lisenceURL;
  String? phone;
  Riders({
    this.name,
    this.email,
    this.passowrd,
    this.icURL,
    this.lisenceURL,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'passowrd': passowrd,
      'icURL': icURL,
      'lisenceURL': lisenceURL,
      'phone': phone,
    };
  }

  factory Riders.fromMap(Map<String, dynamic> map) {
    return Riders(
      name: map['name'],
      email: map['email'],
      passowrd: map['passowrd'],
      icURL: map['icURL'],
      lisenceURL: map['lisenceURL'],
      phone: map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Riders.fromJson(String source) => Riders.fromMap(json.decode(source));
}
