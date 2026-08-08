import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "About",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            //========================================================
            // HEADER
            //========================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: const LinearGradient(
                  colors: [Color(0xFF2E7D32), Color.fromARGB(255, 91, 133, 91)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.self_improvement,
                      size: 50,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    "Voice-Based Yoga Assistant",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "AI Powered Pranayama Recognition",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "Version 1.0.0",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            //========================================================
            // ABOUT PROJECT
            //========================================================
            _sectionTitle(Icons.info_outline, "About Project"),

            const SizedBox(height: 12),

            _infoCard(
              child: const Text(
                "Voice-Based Yoga Assistant is an Artificial Intelligence powered mobile application that recognizes Om and Bhramari Pranayama using voice patterns. The application provides real-time prediction, practice history, dashboard analytics, statistics and PDF reports to assist users during yoga practice.",
                style: TextStyle(fontSize: 14, height: 1.6),
              ),
            ),

            const SizedBox(height: 22),

            //========================================================
            // FEATURES
            //========================================================
            _sectionTitle(Icons.star, "Key Features"),

            const SizedBox(height: 8),

            _infoCard(
              child: Column(
                children: const [
                  FeatureTile(
                    icon: Icons.mic,
                    title: "Real-time Voice Recognition",
                  ),

                  Divider(),

                  FeatureTile(
                    icon: Icons.self_improvement,
                    title: "Om Detection",
                  ),

                  Divider(),

                  FeatureTile(
                    icon: Icons.graphic_eq,
                    title: "Bhramari Detection",
                  ),

                  Divider(),

                  FeatureTile(
                    icon: Icons.bar_chart,
                    title: "Dashboard Analytics",
                  ),

                  Divider(),

                  FeatureTile(icon: Icons.history, title: "Session History"),

                  Divider(),

                  FeatureTile(
                    icon: Icons.bar_chart,
                    title: "Statistics Report",
                  ),

                  Divider(),

                  FeatureTile(
                    icon: Icons.picture_as_pdf,
                    title: "Export Reports to PDF",
                  ),

                  Divider(),

                  FeatureTile(
                    icon: Icons.verified,
                    title: "Confidence Score Prediction",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            //========================================================
            // TECHNOLOGY
            //========================================================
            _sectionTitle(Icons.memory, "Technology Stack"),

            const SizedBox(height: 12),

            _infoCard(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: const [
                  TechChip("Flutter"),

                  TechChip("Flask"),

                  TechChip("TensorFlow"),

                  TechChip("SQLite"),

                  TechChip("Librosa"),

                  TechChip("FFmpeg"),

                  TechChip("Python"),

                  TechChip("Machine Learning"),

                  TechChip("Artificial Intelligence"),
                ],
              ),
            ),

            const SizedBox(height: 22),

            //========================================================
            // AI MODEL
            //========================================================
            _sectionTitle(Icons.psychology, "AI Model and Classification"),

            const SizedBox(height: 12),

            _infoCard(
              child: Column(
                children: const [
                  FeatureTile(
                    icon: Icons.smart_toy,
                    title: "TensorFlow Neural Network",
                  ),

                  Divider(),

                  FeatureTile(
                    icon: Icons.multitrack_audio,
                    title: "MFCC Feature Extraction",
                  ),

                  Divider(),

                  FeatureTile(
                    icon: Icons.analytics,
                    title: "Audio Classification",
                  ),

                  Divider(),

                  FeatureTile(
                    icon: Icons.speed,
                    title: "Confidence Estimation",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            //========================================================
            // PROJECT STATISTICS
            //========================================================
            _sectionTitle(Icons.bar_chart, "Project Statistics"),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: StatisticCard(
                    title: "Supported\nPranayama",
                    value: "2",
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: StatisticCard(
                    title: "Platform",
                    value: "Android",
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: StatisticCard(
                    title: "Backend",
                    value: "Flask",
                    color: Colors.orange,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: StatisticCard(
                    title: "Database",
                    value: "SQLite",
                    color: Colors.purple,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            //========================================================
            // DEVELOPER
            //========================================================
            _sectionTitle(Icons.person, "Developer"),

            const SizedBox(height: 12),

            _infoCard(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blue, width: 3),
                    ),
                    child: const CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage("assets/images/raghav.jpeg"),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Raghav Kumar Jha",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Master of Computer Application",
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 6),

                  const Text("MAKAUT"),

                  const SizedBox(height: 12),

                  const Text(
                    "Major Project 2026",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Divider(),

            const SizedBox(height: 15),

            const Text(
              "Made with ❤️ using Flutter & Machine Learning",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 10),

            const Text(
              "© 2026 Voice-Based Yoga Assistant",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue),

        const SizedBox(width: 8),

        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _infoCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}

class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const FeatureTile({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade50,
        child: Icon(icon, color: Colors.blue),
      ),

      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),

      trailing: const Icon(Icons.check_circle, color: Colors.green),
    );
  }
}

class TechChip extends StatelessWidget {
  final String label;

  const TechChip(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.blue.shade50,

      avatar: const Icon(Icons.code, size: 18, color: Colors.blue),

      label: Text(label),
    );
  }
}

class StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const StatisticCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: color.withOpacity(.08),

        borderRadius: BorderRadius.circular(18),

        border: Border.all(color: color.withOpacity(.25)),
      ),

      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
