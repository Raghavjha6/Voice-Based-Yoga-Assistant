import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({super.key});

  String greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning ☀️";
    } else if (hour < 17) {
      return "Good Afternoon 🌿";
    } else {
      return "Good Evening 👋";
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = DateFormat("EEEE, dd MMMM yyyy").format(DateTime.now());

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [Color(0xFF2E7D32), Color(0xFF43A047)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greeting(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Voice-Based Yoga Assistant",
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.white70, size: 18),
              const SizedBox(width: 8),
              Text(
                today,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
