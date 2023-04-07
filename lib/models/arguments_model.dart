import 'dart:convert';

class Args {
  int? index;
  String? title;
  Args({
    this.index,
    this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'title': title,
    };
  }

  factory Args.fromMap(Map<String, dynamic> map) {
    return Args(
      index: map['index']?.toInt(),
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Args.fromJson(String source) => Args.fromMap(json.decode(source));
}
