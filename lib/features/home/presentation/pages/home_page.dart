import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kohab/core/components/my_drawer.dart';
import 'package:kohab/features/habits/presentation/pages/habit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [const HabitPage(), Container(), Container(), Container()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('KOHAB'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.add),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.inversePrimary),
        unselectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        selectedLabelStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        useLegacyColorScheme: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Habits'),
          BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: 'Friends'),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: 'Leaderboard'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SafeArea(child: _screens[_currentIndex]),
    );
  }
}
