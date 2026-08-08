import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'providers/dashboard_provider.dart';
import 'providers/history_provider.dart';
import 'providers/live_provider.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardProvider()),

        ChangeNotifierProvider(create: (_) => HistoryProvider()),

        ChangeNotifierProvider(create: (_) => LiveProvider()),
      ],
      child: const YogaAssistantApp(),
    ),
  );
}

class YogaAssistantApp extends StatelessWidget {
  const YogaAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Voice-Based Yoga Assistant",
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
