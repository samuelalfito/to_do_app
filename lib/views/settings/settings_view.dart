import 'package:flutter/material.dart';

import '../../main.dart';

class SettingsView extends StatefulWidget {
  SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late String _themeText = 'System Mode';
  late bool _isDarkMode = ThemeMode.system == ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(_themeText),
                Switch(
                    value: _isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                      if (_isDarkMode) {
                        MyApp.of(context).changeTheme(ThemeMode.dark);
                        _themeText = 'Dark Mode';
                      } else {
                        MyApp.of(context).changeTheme(ThemeMode.light);
                        _themeText = 'Light Mode';
                      }
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
