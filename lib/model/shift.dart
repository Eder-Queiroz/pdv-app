class Shift {
  final int id;
  final int userId;
  final DateTime startTime;
  final DateTime? endTime;
  final double startCash;
  final double? endCash;
  final bool isOpened;

  Shift({
    required this.id,
    required this.userId,
    required this.startTime,
    this.endTime,
    required this.startCash,
    this.endCash,
    this.isOpened = true,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['id'],
      userId: json['user_id'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      startCash: json['start_cash'],
      endCash: json['end_cash'],
      isOpened: json['is_opened'],
    );
  }
}
