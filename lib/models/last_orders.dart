import 'dart:convert';

class LastOrders {
  final int orderId;
  final double amount;
  final String startTime;
  final String endTime;
  final String StartDate;
  final String EndDate;
  LastOrders({
    required this.orderId,
    required this.amount,
    required this.startTime,
    required this.endTime,
    required this.StartDate,
    required this.EndDate,
  });

  LastOrders copyWith({
    int? orderId,
    double? amount,
    String? startTime,
    String? endTime,
    String? StartDate,
    String? EndDate,
  }) {
    return LastOrders(
      orderId: orderId ?? this.orderId,
      amount: amount ?? this.amount,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      StartDate: StartDate ?? this.StartDate,
      EndDate: EndDate ?? this.EndDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'amount': amount,
      'startTime': startTime,
      'endTime': endTime,
      'StartDate': StartDate,
      'EndDate': EndDate,
    };
  }

  factory LastOrders.fromMap(Map<String, dynamic> map) {
    return LastOrders(
      orderId: map['orderId']?.toInt() ?? 0,
      amount: map['amount']?.toDouble() ?? 0.0,
      startTime: map['startTime'] ?? '',
      endTime: map['endTime'] ?? '',
      StartDate: map['StartDate'] ?? '',
      EndDate: map['EndDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LastOrders.fromJson(String source) =>
      LastOrders.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LastOrders(orderId: $orderId, amount: $amount, startTime: $startTime, endTime: $endTime, StartDate: $StartDate, EndDate: $EndDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LastOrders &&
        other.orderId == orderId &&
        other.amount == amount &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.StartDate == StartDate &&
        other.EndDate == EndDate;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        amount.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        StartDate.hashCode ^
        EndDate.hashCode;
  }
}
