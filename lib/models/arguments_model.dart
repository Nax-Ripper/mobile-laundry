import 'dart:convert';

class Args {
  int? index;
  Args({
     this.index,
  });

  Map<String, dynamic> toMap() {
    return {
      'index': index,
    };
  }

  factory Args.fromMap(Map<String, dynamic> map) {
    return Args(
      index: map['index']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Args.fromJson(String source) => Args.fromMap(json.decode(source));
}
