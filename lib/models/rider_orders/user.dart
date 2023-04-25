import 'dart:convert';

class User {
  String? phoneNumber;
  String? id;
  String? name;
  String? email;
  String? password;
  String? address;
  String? type;
  int? v;

  User({
    this.phoneNumber,
    this.id,
    this.name,
    this.email,
    this.password,
    this.address,
    this.type,
    this.v,
  });

  factory User.fromMap(Map<String, dynamic> data) => User(
        phoneNumber: data['phoneNumber'] as String?,
        id: data['_id'] as String?,
        name: data['name'] as String?,
        email: data['email'] as String?,
        password: data['password'] as String?,
        address: data['address'] as String?,
        type: data['type'] as String?,
        v: data['__v'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'phoneNumber': phoneNumber,
        '_id': id,
        'name': name,
        'email': email,
        'password': password,
        'address': address,
        'type': type,
        '__v': v,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());
}
