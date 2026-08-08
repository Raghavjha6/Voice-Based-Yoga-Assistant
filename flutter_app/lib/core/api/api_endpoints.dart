import 'package:flutter/foundation.dart';

class ApiEndpoints {
  ApiEndpoints._();

  static String get baseUrl {
    if (kIsWeb) {
      // Flutter Web (Chrome)
      return "http://127.0.0.1:5000";
    }

    // Android Emulator
    //return "http://10.0.2.2:5000";

    //Mobile
    return "http://192.168.1.5:5000";

    // return "http://192.168.137.1:5000";
  }

  static String get dashboard => "$baseUrl/api/dashboard";
  static String get history => "$baseUrl/history";
  static String get statistics => "$baseUrl/statistics";
  static String get about => "$baseUrl/about";
  static String get deleteSelectedHistory =>
      "$baseUrl/api/history/delete-selected";
  static String get deleteAllHistory => "$baseUrl/api/history/delete-all";
}
