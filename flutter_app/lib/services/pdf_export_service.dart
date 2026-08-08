import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../models/history_model.dart';

class PdfExportService {
  Future<void> exportSessions({
    required List<HistoryModel> sessions,
    required String reportTitle,
    required String fileName,
  }) async {
    if (sessions.isEmpty) {
      throw Exception("No sessions available for export");
    }

    final pdf = pw.Document();

    final totalDuration = sessions.fold<double>(
      0,
      (total, session) => total + session.duration,
    );

    final generatedAt = DateFormat(
      "dd MMM yyyy, hh:mm a",
    ).format(DateTime.now());

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,

        margin: const pw.EdgeInsets.all(32),

        build: (context) {
          return [
            pw.Text(
              reportTitle,
              style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
            ),

            pw.SizedBox(height: 8),

            pw.Text("Voice-Based Yoga Assistant"),

            pw.SizedBox(height: 4),

            pw.Text("Generated: $generatedAt"),

            pw.SizedBox(height: 20),

            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  "Total Sessions: "
                  "${sessions.length}",
                ),

                pw.Text(
                  "Total Duration: "
                  "${totalDuration.toStringAsFixed(2)} sec",
                ),
              ],
            ),

            pw.SizedBox(height: 20),

            pw.TableHelper.fromTextArray(
              headers: const [
                "ID",
                "Date",
                "Time",
                "Pranayama",
                "Duration",
                "Confidence",
              ],

              data: sessions.map((session) {
                return [
                  session.id.toString(),
                  session.date,
                  session.time,
                  session.pranayama,
                  "${session.duration.toStringAsFixed(2)} sec",
                  "${(session.confidence * 100).toStringAsFixed(2)}%",
                ];
              }).toList(),

              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),

              headerDecoration: const pw.BoxDecoration(
                color: PdfColors.grey300,
              ),

              cellAlignment: pw.Alignment.centerLeft,

              cellStyle: const pw.TextStyle(fontSize: 9),
            ),
          ];
        },
      ),
    );

    await Printing.sharePdf(bytes: await pdf.save(), filename: fileName);
  }
}
