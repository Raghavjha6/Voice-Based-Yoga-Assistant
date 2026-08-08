import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/history_model.dart';
import '../services/pdf_export_service.dart';
import '../services/session_service.dart';

class HistoryProvider extends ChangeNotifier {
  final SessionService _service = SessionService();

  final PdfExportService _pdfService = PdfExportService();

  List<HistoryModel> sessions = [];

  final Set<int> selectedSessionIds = {};

  bool loading = false;
  bool deleting = false;

  String? error;

  bool get selectionMode => selectedSessionIds.isNotEmpty;

  int get selectedCount => selectedSessionIds.length;

  List<HistoryModel> get recentSessions {
    return sessions.take(5).toList();
  }

  Future<void> loadHistory() async {
    loading = true;
    error = null;

    notifyListeners();

    try {
      sessions = await _service.getHistory();
    } catch (e) {
      error = "Unable to load session history";
    } finally {
      loading = false;

      notifyListeners();
    }
  }

  void toggleSelection(int sessionId) {
    if (selectedSessionIds.contains(sessionId)) {
      selectedSessionIds.remove(sessionId);
    } else {
      selectedSessionIds.add(sessionId);
    }

    notifyListeners();
  }

  bool isSelected(int sessionId) {
    return selectedSessionIds.contains(sessionId);
  }

  void clearSelection() {
    selectedSessionIds.clear();

    notifyListeners();
  }

  Future<void> deleteSelected() async {
    if (selectedSessionIds.isEmpty) {
      return;
    }

    deleting = true;

    notifyListeners();

    try {
      await _service.deleteSelectedSessions(selectedSessionIds.toList());

      selectedSessionIds.clear();

      await loadHistory();
    } finally {
      deleting = false;

      notifyListeners();
    }
  }

  Future<void> deleteAll() async {
    deleting = true;

    notifyListeners();

    try {
      await _service.deleteAllSessions();

      selectedSessionIds.clear();

      await loadHistory();
    } finally {
      deleting = false;

      notifyListeners();
    }
  }

  Future<void> exportToday() async {
    final today = DateFormat("yyyy-MM-dd").format(DateTime.now());

    final todaySessions = sessions
        .where((session) => session.date == today)
        .toList();

    await _pdfService.exportSessions(
      sessions: todaySessions,
      reportTitle: "Today's Practice Sessions",
      fileName: "today_practice_sessions.pdf",
    );
  }

  Future<void> exportAll() async {
    await _pdfService.exportSessions(
      sessions: sessions,
      reportTitle: "All Practice Sessions",
      fileName: "all_practice_sessions.pdf",
    );
  }
}
