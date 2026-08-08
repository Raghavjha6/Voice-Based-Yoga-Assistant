import '../core/api/api_endpoints.dart';
import '../core/api/api_service.dart';

import '../models/statistics_model.dart';
import '../models/history_model.dart';

class SessionService {
  final ApiService api = ApiService();

  Future<StatisticsModel> getDashboard() async {
    final json = await api.get(ApiEndpoints.dashboard);

    return StatisticsModel.fromJson(json);
  }

  Future<List<HistoryModel>> getHistory() async {
    final json = await api.get(ApiEndpoints.history);

    return (json as List).map((e) => HistoryModel.fromJson(e)).toList();
  }

  Future<void> deleteSelectedSessions(List<int> sessionIds) async {
    await api.post(
      ApiEndpoints.deleteSelectedHistory,
      body: {"session_ids": sessionIds},
    );
  }

  Future<void> deleteAllSessions() async {
    await api.post(ApiEndpoints.deleteAllHistory);
  }
}
