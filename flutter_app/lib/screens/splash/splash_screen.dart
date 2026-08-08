import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff2E7D32), Color(0xff43A047)],

            begin: Alignment.topLeft,

            end: Alignment.bottomRight,
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Icon(Icons.self_improvement, size: 110, color: Colors.white),

            const SizedBox(height: 25),

            Text(
              AppStrings.appName,

              textAlign: TextAlign.center,

              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "AI Powered Pranayama Recognition",

              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),

            const SizedBox(height: 50),

            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
