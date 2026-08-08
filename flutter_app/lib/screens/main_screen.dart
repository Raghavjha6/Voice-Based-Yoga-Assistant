import 'package:flutter/material.dart';

import 'about/about_screen.dart';
import 'history/history_screen.dart';
import 'home/home_screen.dart';
import 'statistics/statistics_screen.dart';
import 'live/live_practice_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    HistoryScreen(),
    StatisticsScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      // Floating Practice Button
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.mic),
        label: const Text("Practice"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LivePracticeScreen()),
          );
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom Navigation
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,

        child: SizedBox(
          height: 70,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              // Home
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: currentIndex == 0 ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
              ),

              // History
              IconButton(
                icon: Icon(
                  Icons.history,
                  color: currentIndex == 1 ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
              ),

              // Space for FAB
              const SizedBox(width: 40),

              // Statistics
              IconButton(
                icon: Icon(
                  Icons.bar_chart,
                  color: currentIndex == 2 ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
              ),

              // About
              IconButton(
                icon: Icon(
                  Icons.info,
                  color: currentIndex == 3 ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    currentIndex = 3;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
