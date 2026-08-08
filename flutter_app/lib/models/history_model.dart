class HistoryModel {
  final int id;
  final String date;
  final String time;
  final String pranayama;
  final double duration;
  final double confidence;

  HistoryModel({
    required this.id,
    required this.date,
    required this.time,
    required this.pranayama,
    required this.duration,
    required this.confidence,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json["id"] ?? 0,

      date: json["date"]?.toString() ?? "",

      time: json["time"]?.toString() ?? "",

      pranayama: json["pranayama"]?.toString() ?? "Unknown",

      duration: (json["duration"] as num?)?.toDouble() ?? 0.0,

      confidence: (json["confidence"] as num?)?.toDouble() ?? 0.0,
    );
  }
}
