import 'package:flutter/material.dart';
import 'package:kohab/core/components/my_habit_tile.dart';
import 'package:kohab/features/habits/domain/entities/habit_entity.dart';

class HabitList extends StatelessWidget {
  final List<HabitEntity> habits;

  const HabitList({
    super.key,
    required this.habits,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: habits.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, index) {
        final habit = habits[index];
        return MyHabitTile(
          isCompleted: false,
          text: habit.text,
          onChanged: (_) {},
          editHabit: () {},
          deleteHabit: () {},
        );
      },
    );
  }
}
