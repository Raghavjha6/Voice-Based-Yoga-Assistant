import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/dashboard_provider.dart';
import '../../providers/history_provider.dart';

import '../../widgets/dashboard_card.dart';
import '../../widgets/insight_card.dart';
import '../../widgets/section_title.dart';
import '../../widgets/session_card.dart';
import '../../widgets/welcome_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await context.read<DashboardProvider>().loadDashboard();
      await context.read<HistoryProvider>().loadHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = context.watch<DashboardProvider>();
    final historyProvider = context.watch<HistoryProvider>();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await dashboardProvider.loadDashboard();
          await historyProvider.loadHistory();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),

              const WelcomeBanner(),

              const SizedBox(height: 30),

              const SectionTitle(
                title: "Summary",
                icon: Icons.dashboard_customize,
              ),

              const SizedBox(height: 20),

              if (dashboardProvider.error != null)
                Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    dashboardProvider.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

              if (dashboardProvider.isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.0,
                  children: [
                    DashboardCard(
                      icon: Icons.spa,
                      title: "Om",
                      value:
                          dashboardProvider.statistics?.omCount.toString() ??
                          "--",
                      color: Colors.blue,
                    ),

                    DashboardCard(
                      icon: Icons.graphic_eq,
                      title: "Bhramari",
                      value:
                          dashboardProvider.statistics?.bhramariCount
                              .toString() ??
                          "--",
                      color: Colors.green,
                    ),

                    DashboardCard(
                      icon: Icons.timer,
                      title: "Sessions",
                      value:
                          dashboardProvider.statistics?.totalSessions
                              .toString() ??
                          "--",
                      color: Colors.orange,
                    ),

                    DashboardCard(
                      icon: Icons.access_time,
                      title: "Duration",
                      value:
                          "${dashboardProvider.statistics?.totalDuration ?? 0} s",
                      color: Colors.red,
                    ),
                  ],
                ),

              const SizedBox(height: 30),

              const SectionTitle(
                title: "Today's Insights",
                icon: Icons.insights,
              ),

              const SizedBox(height: 15),

              InsightCard(
                icon: Icons.today,
                title: "Today's Sessions",
                value:
                    dashboardProvider.statistics?.todaySessions.toString() ??
                    "0",
              ),

              const SizedBox(height: 12),

              InsightCard(
                icon: Icons.timelapse,
                title: "Today's Duration",
                value:
                    "${dashboardProvider.statistics?.todayDuration.toStringAsFixed(2) ?? "0.00"} sec",
              ),

              const SizedBox(height: 12),

              InsightCard(
                icon: Icons.star,
                title: "Average Confidence",
                value:
                    "${dashboardProvider.statistics?.averageConfidence ?? 0} %",
              ),

              const SizedBox(height: 12),

              InsightCard(
                icon: Icons.self_improvement,
                title: "Last Detection",
                value:
                    dashboardProvider.statistics?.lastDetection ??
                    "No Detection",
              ),

              const SizedBox(height: 35),

              const SectionTitle(title: "Recent Sessions", icon: Icons.history),

              const SizedBox(height: 15),

              SizedBox(
                height: 220,
                child: historyProvider.loading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: historyProvider.recentSessions.length,
                        itemBuilder: (context, index) {
                          final session = historyProvider.recentSessions[index];

                          return SessionCard(session: session);
                        },
                      ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
