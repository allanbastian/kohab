import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:kohab/database/habit_database.dart';
import 'package:kohab/models/habit.dart';

void main() {
  group('HabitDatabase Tests', () {
    late HabitDatabase habitDatabase;
    late Directory tempDir;

    setUp(() async {
      // Create a temporary directory for the test database
      tempDir = await Directory.systemTemp.createTemp();

      // Initialize Isar for testing
      final isar = await Isar.open(
        [HabitSchema],
        directory: tempDir.path,
      );

      habitDatabase = HabitDatabase();
      // Use reflection to set the private isar instance
      final field = habitDatabase.runtimeType.toString();
      if (field.contains('_isar')) {
        (habitDatabase as dynamic)._isar = isar;
      }
    });

    tearDown(() async {
      // Clean up after each test
      await habitDatabase.clear();
      await tempDir.delete(recursive: true);
    });

    test('addHabit should add a new habit', () async {
      await HabitDatabase.initialize();
      // Add a habit
      await habitDatabase.addHabit('Test Habit');

      // Verify habit was added
      await habitDatabase.readHabits();
      List<Habit> habits = habitDatabase.currentHabits;
      expect(habits.length, 1);
      expect(habits.first.name, 'Test Habit');
      expect(habits.first.completedDays, 0);
    });

    test('updateHabitCompletion should toggle habit completion', () async {
      // Add a habit
      await habitDatabase.addHabit('Test Habit');
      final habits = habitDatabase.currentHabits;
      final habitId = habits.first.id;

      // Update completion status
      await habitDatabase.updateHabitCompletion(habitId, true);

      // Verify update
      final updatedHabits = habitDatabase.currentHabits;
      expect(updatedHabits.first.completedDays, 1);
    });

    test('editHabit should update habit name', () async {
      // Add a habit
      await habitDatabase.addHabit('Original Name');
      final habits = habitDatabase.currentHabits;
      final habitId = habits.first.id;

      // Edit habit
      await habitDatabase.updateHabitName(habitId, 'New Name');

      // Verify update
      final updatedHabits = habitDatabase.currentHabits;
      expect(updatedHabits.first.name, 'New Name');
    });

    test('deleteHabit should remove habit', () async {
      // Add a habit
      await habitDatabase.addHabit('Test Habit');
      final habits = habitDatabase.currentHabits;
      final habitId = habits.first.id;

      // Delete habit
      await habitDatabase.deleteHabit(habitId);

      // Verify deletion
      final remainingHabits = habitDatabase.currentHabits;
      expect(remainingHabits.isEmpty, true);
    });

    test('clear should remove all habits', () async {
      // Add multiple habits
      await habitDatabase.addHabit('Habit 1');
      await habitDatabase.addHabit('Habit 2');
      await habitDatabase.addHabit('Habit 3');

      // Clear all habits
      await habitDatabase.clear();

      // Verify all habits were removed
      final habits = habitDatabase.currentHabits;
      expect(habits.isEmpty, true);
    });

    test('getCurrentHabits returns habits in correct order', () async {
      // Add habits in specific order
      await habitDatabase.addHabit('Habit C');
      await habitDatabase.addHabit('Habit A');
      await habitDatabase.addHabit('Habit B');

      // Get habits
      final habits = habitDatabase.currentHabits;

      // Verify order (assuming default ordering by creation time)
      expect(habits.length, 3);
      expect(habits[0].name, 'Habit C');
      expect(habits[1].name, 'Habit A');
      expect(habits[2].name, 'Habit B');
    });
  });
}
