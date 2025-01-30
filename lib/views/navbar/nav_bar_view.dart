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
        builder: (context, taskModel, child) => LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth < 600) {
                return _phoneLayout();
              } else {
                return _computerLayout();
              }
            }));
  }

  Widget _phoneLayout() {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline_rounded), label: 'Add Task'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _computerLayout() {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _currentIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add_circle_outline_rounded),
                label: Text('Add Task'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(child: _tabs[_currentIndex]),
        ],
      ),
    );
  }
}
