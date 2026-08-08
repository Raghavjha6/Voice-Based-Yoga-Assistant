import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: const [
          ListTile(leading: Icon(Icons.dark_mode), title: Text("Dark Mode")),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
          ),
          Divider(),
          ListTile(leading: Icon(Icons.info), title: Text("Version 1.0")),
        ],
      ),
    );
  }
}
