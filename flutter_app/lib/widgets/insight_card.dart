import 'package:flutter/material.dart';

class InsightCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const InsightCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade100,
          child: Icon(icon, color: Colors.green),
        ),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
