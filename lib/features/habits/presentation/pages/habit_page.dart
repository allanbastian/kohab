import 'package:flutter/material.dart';
import 'package:kohab/core/components/date_selector.dart';
import 'package:kohab/core/components/my_habit_tile.dart';

class HabitPage extends StatefulWidget {
  const HabitPage({super.key});

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        //Date selector
        const DateSelector(),
        const SizedBox(height: 12),
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(child: Text('All')),
            Tab(child: Text('Personal')),
            Tab(child: Text('Group')),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // All habits
              Expanded(
                child: ListView.separated(
                  itemCount: 10,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return MyHabitTile(
                      isCompleted: false,
                      text: '$index',
                      onChanged: (_) {},
                      editHabit: () {},
                      deleteHabit: () {},
                    );
                  },
                ),
              ),
              //Personal habits
              Expanded(
                child: ListView.separated(
                  itemCount: 4,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return MyHabitTile(
                      isCompleted: false,
                      text: '$index',
                      onChanged: (_) {},
                      editHabit: () {},
                      deleteHabit: () {},
                    );
                  },
                ),
              ),
              //Group habits
              Expanded(
                child: ListView.separated(
                  itemCount: 6,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return MyHabitTile(
                      isCompleted: false,
                      text: '$index',
                      onChanged: (_) {},
                      editHabit: () {},
                      deleteHabit: () {},
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
