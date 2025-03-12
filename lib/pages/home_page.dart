import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kohab/components/date_selector.dart';
import 'package:kohab/components/my_drawer.dart';
import 'package:kohab/components/my_habit_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('KOHAB'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.add,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          //Date selector
          const DateSelector(),
          //Task cards
          MyHabitTile(
            isCompleted: false,
            text: 'Habit',
            onChanged: (value) {},
            editHabit: () {},
            deleteHabit: () {},
          ),
        ],
      ),
    );
  }
}
