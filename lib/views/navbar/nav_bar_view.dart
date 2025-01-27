import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/data/task_service.dart';
import 'package:to_do_app/views/createtask/create_task_view.dart';
import 'package:to_do_app/views/settings/settings_view.dart';

import '../homepage/home_view.dart';

class NavBarView extends StatefulWidget {
  const NavBarView({super.key});

  @override
  _NavBarViewState createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    HomeView(),
    CreateTaskView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskService>(
      builder: (context, taskModel, child) => Scaffold(
        body: _tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline_rounded), label: 'Add Task'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}