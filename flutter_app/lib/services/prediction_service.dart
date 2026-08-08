import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/prediction_model.dart';

class PredictionService {
  // Android Emulator
  // static const String baseUrl =
  //     "http://10.0.2.2:5000";

  // Chrome/Web
  // static const String baseUrl =
  //     "http://127.0.0.1:5000";

  static const String baseUrl = "http://192.168.1.5:5000";

  // static const String baseUrl = "http://192.168.137.1:5000";

  Future<PredictionModel> predict(File audioFile) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/api/predict"),
    );

    request.files.add(
      await http.MultipartFile.fromPath("audio", audioFile.path),
    );

    final response = await request.send();

    final body = await response.stream.bytesToString();

    return PredictionModel.fromJson(jsonDecode(body));
  }

  Future<void> startLiveSession() async {
    final response = await http.post(Uri.parse("$baseUrl/api/live/start"));

    if (response.statusCode != 200) {
      throw Exception("Unable to start live session");
    }
  }

  Future<Map<String, dynamic>> stopLiveSession() async {
    final response = await http.post(Uri.parse("$baseUrl/api/live/stop"));

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> sendLiveChunk(File audioFile) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/api/live/chunk"),
    );

    request.files.add(
      await http.MultipartFile.fromPath("audio", audioFile.path),
    );

    final response = await request.send();

    final body = await response.stream.bytesToString();

    return jsonDecode(body);
  }
}
