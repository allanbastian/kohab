import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kohab/core/components/my_button.dart';
import 'package:kohab/core/components/my_drawer.dart';
import 'package:kohab/core/components/my_snackbar.dart';
import 'package:kohab/core/components/my_text_form_field.dart';
import 'package:kohab/features/habits/domain/entities/habit_entity.dart';
import 'package:kohab/features/habits/domain/usecases/add_new_habit_usecase.dart';
import 'package:kohab/features/habits/domain/usecases/get_all_habits_usecase.dart';
import 'package:kohab/features/habits/presentation/pages/habit_page.dart';
import 'package:kohab/service_locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late TextEditingController _addNewHabitController;

  final List<Widget> _screens = [const HabitPage(), Container(), Container(), Container()];

  @override
  void initState() {
    super.initState();
    _addNewHabitController = TextEditingController();
  }

  @override
  void dispose() {
    _addNewHabitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('KOHAB'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  bool isCollaborative = false;
                  return AlertDialog(
                    content: Container(
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.transparent,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MyTextFormField(
                            hintText: "Add new habit",
                            obscureText: false,
                            controller: _addNewHabitController,
                          ),
                          Row(
                            children: [
                              const Text('Is collaborative? '),
                              const Spacer(),
                              CupertinoSwitch(
                                value: isCollaborative,
                                onChanged: (_) => setState(() {
                                  isCollaborative = !isCollaborative;
                                }),
                              ),
                            ],
                          ),
                          MyButton(
                            text: 'Submit',
                            onTap: () async {
                              HabitEntity entity = HabitEntity(
                                id: null,
                                text: _addNewHabitController.text.trim(),
                                createdBy: sl<SupabaseClient>().auth.currentUser!.id,
                                isCollaborative: isCollaborative,
                                createdAt: DateTime.now(),
                              );
                              final result = await sl<AddNewHabitUsecase>().call(params: entity);
                              result.fold(
                                (err) => MySnackbar.displayErrorMessage(err, context),
                                (_) => sl<GetAllHabitsUsecase>().call(),
                              );
                            },
                            color: Theme.of(context).colorScheme.surfaceBright,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
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
