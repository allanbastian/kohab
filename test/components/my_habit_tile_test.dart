import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kohab/components/my_habit_tile.dart';

void main() {
  group('MyHabitTile Widget Tests', () {
    testWidgets(
      'MyHabitTile displays correct habit name',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MyHabitTile(
                text: 'Exercise',
                isCompleted: false,
                editHabit: () {},
                deleteHabit: () {},
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.text('Exercise'), findsOneWidget);
      },
    );

    // Add more widget tests...
  });
}
