class PredictionModel {
  final bool success;
  final String prediction;
  final double confidence;
  final double duration;

  PredictionModel({
    required this.success,
    required this.prediction,
    required this.confidence,
    required this.duration,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      success: json["success"] ?? false,
      prediction: json["prediction"] ?? "",
      confidence: (json["confidence"] ?? 0).toDouble(),
      duration: (json["duration"] ?? 0).toDouble(),
    );
  }
}
