class StatisticsModel {
  final int omCount;
  final int bhramariCount;

  final int totalSessions;
  final double totalDuration;

  final double averageConfidence;

  final String? lastDetection;

  final int todaySessions;
  final double todayDuration;

  StatisticsModel({
    required this.omCount,
    required this.bhramariCount,
    required this.totalSessions,
    required this.totalDuration,
    required this.averageConfidence,
    required this.lastDetection,
    required this.todaySessions,
    required this.todayDuration,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      omCount: json["om_count"] ?? 0,

      bhramariCount: json["bhramari_count"] ?? 0,

      totalSessions: json["total_sessions"] ?? 0,

      totalDuration: (json["total_duration"] as num?)?.toDouble() ?? 0.0,

      averageConfidence:
          (json["average_confidence"] as num?)?.toDouble() ?? 0.0,

      lastDetection: json["last_detection"]?.toString(),

      todaySessions: json["today_sessions"] ?? 0,

      todayDuration: (json["today_duration"] as num?)?.toDouble() ?? 0.0,
    );
  }
}
