import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/live_provider.dart';

class LivePracticeScreen extends StatelessWidget {
  const LivePracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LiveProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Start Practice"), centerTitle: true),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              const SizedBox(height: 20),

              const Text(
                "Voice-Based Yoga Assistant",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 40),

              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: provider.practicing ? 170 : 150,
                width: provider.practicing ? 170 : 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: provider.practicing
                      ? Colors.red.shade50
                      : Colors.green.shade50,
                  border: Border.all(
                    color: provider.practicing ? Colors.red : Colors.green,
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (provider.practicing ? Colors.red : Colors.green)
                          .withOpacity(.25),
                      blurRadius: 25,
                      spreadRadius: 6,
                    ),
                  ],
                ),
                child: Icon(
                  provider.practicing ? Icons.graphic_eq : Icons.mic,
                  size: 80,
                  color: provider.practicing ? Colors.red : Colors.green,
                ),
              ),

              const SizedBox(height: 20),

              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        provider.practicing
                            ? Icons.radio_button_checked
                            : Icons.pause_circle,
                        color: provider.practicing ? Colors.red : Colors.grey,
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          provider.practicing
                              ? "Listening..."
                              : "Ready to Practice",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: () async {
                  if (provider.practicing) {
                    final summary = await provider.stopPractice();

                    if (!context.mounted) return;

                    await showDialog(
                      context: context,
                      builder: (_) {
                        final data = summary["summary"];

                        return AlertDialog(
                          title: Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 28,
                              ),

                              const SizedBox(width: 10),

                              const Expanded(
                                child: Text(
                                  "Practice Summary",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),

                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Om",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),

                              Text("Count : ${data["Om"]["count"]}"),

                              Text(
                                "Duration : ${(data["Om"]["duration"] as num).toDouble().toStringAsFixed(2)} sec",
                              ),

                              const SizedBox(height: 20),

                              const Text(
                                "Bhramari",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),

                              Text("Count : ${data["Bhramari"]["count"]}"),

                              Text(
                                "Duration : ${(data["Bhramari"]["duration"] as num).toDouble().toStringAsFixed(2)} sec",
                              ),
                            ],
                          ),

                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },

                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    await provider.startPractice();
                  }
                },

                icon: Icon(provider.practicing ? Icons.stop : Icons.play_arrow),

                label: Text(
                  provider.practicing ? "Stop Practice" : "Start Practice",
                ),
              ),

              const SizedBox(height: 30),

              if (provider.loading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      CircularProgressIndicator(),

                      SizedBox(height: 10),

                      Text(
                        "Analyzing voice...",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),

              if (provider.currentPrediction.isNotEmpty)
                Card(
                  elevation: 5,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(20),

                    child: Column(
                      children: [
                        const Text(
                          "Latest Detection",
                          style: TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          provider.currentPrediction,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),

                          child: LinearProgressIndicator(
                            value: provider.currentConfidence / 100,
                            minHeight: 10,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "${provider.currentConfidence.toStringAsFixed(2)} %",
                        ),

                        const SizedBox(height: 15),

                        Text(
                          "Duration : ${provider.currentDuration.toStringAsFixed(2)} sec",
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Live Session Summary",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: _SummaryCard(
                          title: "Om",
                          icon: Icons.spa,
                          color: Colors.blue,
                          count: provider.omCount,
                          duration: provider.omDuration,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _SummaryCard(
                          title: "Bhramari",
                          icon: Icons.graphic_eq,
                          color: Colors.green,
                          count: provider.bhramariCount,
                          duration: provider.bhramariDuration,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final int count;
  final double duration;

  const _SummaryCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.count,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),

      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          children: [
            Icon(icon, color: color, size: 34),

            const SizedBox(height: 10),

            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),

            const SizedBox(height: 15),

            Text(
              "$count",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "${duration.toStringAsFixed(1)} sec",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
