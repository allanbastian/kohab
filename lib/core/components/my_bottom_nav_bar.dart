import 'package:flutter/material.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      type: BottomNavigationBarType.shifting,
      selectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.inversePrimary),
      unselectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
      selectedLabelStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary, fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Habits'),
        BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: 'Friends'),
        BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: 'Leaderboard'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
