import 'package:flutter/material.dart';

import '../../main.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Page'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () => MyApp.of(context).changeTheme(ThemeMode.light),
              child: Text('Light')),
          ElevatedButton(
              onPressed: () => MyApp.of(context).changeTheme(ThemeMode.dark),
              child: Text('Dark')),
        ],
      ),
    );
  }
}