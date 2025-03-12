import 'package:flutter/material.dart';
import 'package:kohab/components/my_drawer.dart';
import 'package:kohab/components/my_habit_tile.dart';
import 'package:kohab/components/my_heatmap.dart';
import 'package:kohab/database/habit_database.dart';
import 'package:kohab/models/habit.dart';
import 'package:kohab/utils/habit_utils.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    Provider.of<HabitDatabase>(context, listen: false).readHabits();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(hintText: 'Create a new habit'),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                String newHabitName = textController.text.trim();
                context.read<HabitDatabase>().addHabit(newHabitName);
                Navigator.pop(context);
                textController.clear();
              },
              child: const Text('Save'),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                textController.clear();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void editHabitBox(Habit habit) {
    textController.text = habit.name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              String newHabitName = textController.text.trim();
              context.read<HabitDatabase>().updateHabitName(habit.id, newHabitName);
              Navigator.pop(context);
              textController.clear();
            },
            child: const Text('Save'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              textController.clear();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void deletHabitBox(Habit habit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Are you sure you want to delete?"),
        actions: [
          MaterialButton(
            onPressed: () {
              context.read<HabitDatabase>().deleteHabit(habit.id);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void checkHabitOnOff(bool? value, Habit habit) {
    if (value != null) {
      context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      body: ListView(
        children: [
          _buildHeatMap(),
          _buildHabitList(),
        ],
      ),
    );
  }

  Widget _buildHeatMap() {
    final habitDatabase = context.watch<HabitDatabase>();
    List<Habit> currentHabits = habitDatabase.currentHabits;
    return FutureBuilder(
      future: habitDatabase.getFirstLaunchDate(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MyHeatmap(startDate: snapshot.data!, datasets: prepareHeatMapData(currentHabits));
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildHabitList() {
    final habitDatabase = context.watch<HabitDatabase>();
    List<Habit> currentHabits = habitDatabase.currentHabits;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: currentHabits.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final habit = currentHabits[index];
        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);
        return MyHabitTile(
          isCompleted: isCompletedToday,
          text: habit.name,
          onChanged: (value) => checkHabitOnOff(value, habit),
          editHabit: () => editHabitBox(habit),
          deleteHabit: () => deletHabitBox(habit),
        );
      },
    );
  }
}
