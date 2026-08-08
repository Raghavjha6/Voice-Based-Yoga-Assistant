import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../models/prediction_model.dart';
import '../services/prediction_service.dart';

class LiveProvider extends ChangeNotifier {
  final PredictionService _service = PredictionService();
  final AudioRecorder _recorder = AudioRecorder();

  bool recording = false;
  bool practicing = false;
  bool loading = false;

  PredictionModel? result;

  String currentPrediction = "";

  double currentConfidence = 0;

  double currentDuration = 0;

  int omCount = 0;

  double omDuration = 0;

  int bhramariCount = 0;

  double bhramariDuration = 0;

  Future<void> startRecording() async {
    try {
      final hasPermission = await _recorder.hasPermission();

      if (!hasPermission) {
        print("Microphone permission denied.");
        return;
      }

      final dir = await getTemporaryDirectory();
      final path = "${dir.path}/practice.m4a";

      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
          sampleRate: 22050,
          numChannels: 1,
          bitRate: 64000,
        ),
        path: path,
      );

      print("Recorder started successfully");

      recording = true;
      notifyListeners();
    } catch (e, stackTrace) {
      print("Recording Exception: $e");
      print(stackTrace);
    }
  }

  Future<void> stopRecording() async {
    try {
      final path = await _recorder.stop();

      recording = false;
      notifyListeners();

      if (path == null) return;

      loading = true;
      notifyListeners();

      final response = await _service.sendLiveChunk(File(path));

      currentPrediction = response["prediction"] ?? "";

      currentConfidence = (response["confidence"] ?? 0).toDouble();

      currentDuration = (response["duration"] ?? 0).toDouble();

      final summary = response["summary"];

      omCount = summary["Om"]["count"];

      omDuration = (summary["Om"]["duration"] as num).toDouble();

      bhramariCount = summary["Bhramari"]["count"];

      bhramariDuration = (summary["Bhramari"]["duration"] as num).toDouble();
    } catch (e) {
      print("Prediction Error: $e");
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> startPractice() async {
    try {
      practicing = true;

      // Reset UI state
      currentPrediction = "";
      currentConfidence = 0;
      currentDuration = 0;

      omCount = 0;
      omDuration = 0;

      bhramariCount = 0;
      bhramariDuration = 0;

      // Start backend session
      await _service.startLiveSession();

      notifyListeners();

      _recordLoop();
    } catch (e) {
      loading = false;
      practicing = false;
      notifyListeners();

      print("Start Practice Error: $e");
    }
  }

  Future<Map<String, dynamic>> stopPractice() async {
    practicing = false;

    if (recording) {
      await stopRecording();
    }

    final summary = await _service.stopLiveSession();

    print(summary);

    notifyListeners();

    return summary;
  }

  Future<void> _recordLoop() async {
    while (practicing) {
      await startRecording();

      await Future.delayed(const Duration(seconds: 6));

      if (!practicing) {
        break;
      }

      await stopRecording();

      await Future.delayed(const Duration(milliseconds: 400));
    }
  }
}
