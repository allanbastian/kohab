import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kohab/core/components/my_button.dart';
import 'package:kohab/core/components/my_snackbar.dart';
import 'package:kohab/core/components/my_text_form_field.dart';
import 'package:kohab/features/habits/domain/entities/habit_entity.dart';
import 'package:kohab/features/habits/domain/usecases/add_new_habit_usecase.dart';
import 'package:kohab/features/habits/presentation/blocs/habits_cubit.dart';
import 'package:kohab/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<dynamic> showNewHabitDialog(BuildContext context, TextEditingController controller) {
  return showDialog(
    context: context,
    builder: (context) {
      bool isCollaborative = false;
      return AlertDialog(
        content: StatefulBuilder(
          builder: (context, setState) {
            return Container(
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
                    controller: controller,
                  ),
                  Row(
                    children: [
                      const Text('Is collaborative? '),
                      const Spacer(),
                      CupertinoSwitch(
                        value: isCollaborative,
                        onChanged: (_) => setState(() => isCollaborative = !isCollaborative),
                      ),
                    ],
                  ),
                  MyButton(
                    text: 'Submit',
                    onTap: () async {
                      HabitEntity entity = HabitEntity(
                        id: null,
                        text: controller.text.trim(),
                        createdBy: sl<SupabaseClient>().auth.currentUser!.id,
                        isCollaborative: isCollaborative,
                        createdAt: DateTime.now(),
                      );
                      final result = await sl<AddNewHabitUsecase>().call(params: entity);
                      controller.text = '';
                      Navigator.pop(context);
                      result.fold(
                        (err) => MySnackbar.displayErrorMessage(err, context),
                        (_) => context.read<HabitsCubit>().getAllUserHabits(),
                      );
                    },
                    color: Theme.of(context).colorScheme.surfaceBright,
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
