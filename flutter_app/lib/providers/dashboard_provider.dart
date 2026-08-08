import 'package:flutter/material.dart';

import '../models/statistics_model.dart';
import '../services/session_service.dart';

class DashboardProvider extends ChangeNotifier {
  final SessionService _service = SessionService();

  StatisticsModel? statistics;

  bool isLoading = false;

  String? error;

  Future<void> loadDashboard() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      statistics = await _service.getDashboard();
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
