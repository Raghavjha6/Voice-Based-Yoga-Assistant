import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/history_model.dart';
import '../../providers/history_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<HistoryProvider>().loadHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HistoryProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: provider.selectionMode
            ? IconButton(
                onPressed: provider.clearSelection,
                icon: const Icon(Icons.close),
              )
            : null,

        title: Text(
          provider.selectionMode
              ? "${provider.selectedCount} Selected"
              : "Session History",
        ),

        actions: provider.selectionMode
            ? [
                IconButton(
                  tooltip: "Delete selected",

                  onPressed: provider.deleting
                      ? null
                      : () {
                          _confirmDeleteSelected(context, provider);
                        },

                  icon: const Icon(Icons.delete_outline),
                ),
              ]
            : [
                PopupMenuButton<String>(
                  tooltip: "Export PDF",

                  icon: const Icon(Icons.picture_as_pdf_outlined),

                  onSelected: (value) async {
                    try {
                      if (value == "today") {
                        await provider.exportToday();
                      }

                      if (value == "all") {
                        await provider.exportAll();
                      }
                    } catch (e) {
                      if (!context.mounted) {
                        return;
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("No sessions available for export"),
                        ),
                      );
                    }
                  },

                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: "today",
                      child: Text("Export Today's Sessions"),
                    ),

                    PopupMenuItem(
                      value: "all",
                      child: Text("Export All Sessions"),
                    ),
                  ],
                ),

                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == "delete_all") {
                      _confirmDeleteAll(context, provider);
                    }
                  },

                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: "delete_all",

                      child: Row(
                        children: [
                          Icon(Icons.delete_forever),

                          SizedBox(width: 10),

                          Text("Delete All Sessions"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
      ),

      body: _buildBody(provider),
    );
  }

  Future<void> _confirmDeleteSelected(
    BuildContext context,
    HistoryProvider provider,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text("Delete selected sessions?"),

          content: Text(
            "${provider.selectedCount} "
            "session(s) will be permanently deleted.",
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),

            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await provider.deleteSelected();
    }
  }

  Future<void> _confirmDeleteAll(
    BuildContext context,
    HistoryProvider provider,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text("Delete all sessions?"),

          content: const Text(
            "All session history will be "
            "permanently deleted.",
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),

            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Delete All"),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await provider.deleteAll();
    }
  }

  Widget _buildBody(HistoryProvider provider) {
    if (provider.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return _ErrorView(
        message: provider.error!,
        onRetry: provider.loadHistory,
      );
    }

    if (provider.sessions.isEmpty) {
      return RefreshIndicator(
        onRefresh: provider.loadHistory,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            SizedBox(height: 160),

            Icon(Icons.history, size: 70, color: Colors.grey),

            SizedBox(height: 18),

            Center(
              child: Text(
                "No practice history yet",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),

            SizedBox(height: 8),

            Center(
              child: Text(
                "Complete a practice session "
                "to see it here.",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: provider.loadHistory,

      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),

        padding: const EdgeInsets.symmetric(vertical: 8),

        itemCount: provider.sessions.length,

        itemBuilder: (context, index) {
          final session = provider.sessions[index];

          return _HistoryCard(
            session: session,

            selected: provider.isSelected(session.id),

            onTap: () {
              if (provider.selectionMode) {
                provider.toggleSelection(session.id);
              }
            },

            onLongPress: () {
              provider.toggleSelection(session.id);
            },
          );
        },
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final HistoryModel session;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _HistoryCard({
    required this.session,
    required this.selected,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final isOm = session.pranayama == "Om";

    final color = isOm ? Colors.blue : Colors.green;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),

        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: selected
              ? color.withOpacity(0.12)
              : Theme.of(context).colorScheme.surface,

          borderRadius: BorderRadius.circular(18),

          border: Border.all(color: color.withOpacity(0.20)),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          children: [
            CircleAvatar(
              radius: 25,

              backgroundColor: color.withOpacity(0.12),

              child: Icon(isOm ? Icons.spa : Icons.graphic_eq, color: color),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    session.pranayama,

                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "${session.date}  "
                    "${session.time}",

                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),

                  const SizedBox(height: 7),

                  Row(
                    children: [
                      const Icon(Icons.timelapse, size: 16),

                      const SizedBox(width: 5),

                      Flexible(
                        child: Text(
                          "${session.duration.toStringAsFixed(2)} sec",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                const Icon(Icons.star, size: 21, color: Colors.orange),

                const SizedBox(height: 4),

                Text(
                  "${(session.confidence * 100).toStringAsFixed(2)}%",

                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final Future<void> Function() onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            const Icon(Icons.cloud_off, size: 60, color: Colors.grey),

            const SizedBox(height: 16),

            Text(
              message,
              textAlign: TextAlign.center,

              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 18),

            FilledButton.icon(
              onPressed: () {
                onRetry();
              },

              icon: const Icon(Icons.refresh),

              label: const Text("Try Again"),
            ),
          ],
        ),
      ),
    );
  }
}
