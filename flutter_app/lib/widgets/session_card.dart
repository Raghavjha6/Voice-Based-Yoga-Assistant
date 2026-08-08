import 'package:flutter/material.dart';

import '../models/history_model.dart';

class SessionCard extends StatelessWidget {
  final HistoryModel session;

  const SessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final isOm = session.pranayama == "Om";

    final color = isOm ? Colors.blue : Colors.green;

    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(isOm ? Icons.spa : Icons.graphic_eq, color: color),
          ),

          const SizedBox(height: 12),

          Text(
            session.pranayama,
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),

          const Spacer(),

          Text(
            "Confidence: "
            "${(session.confidence * 100).toStringAsFixed(2)}%",
          ),

          const SizedBox(height: 5),

          Text(
            "Duration: "
            "${session.duration.toStringAsFixed(2)} sec",
          ),

          const SizedBox(height: 5),

          Text(
            "${session.date}  ${session.time}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
