import 'package:flutter/material.dart';

class MyHabitTile extends StatelessWidget {
  const MyHabitTile({
    super.key,
    required this.isCompleted,
    required this.text,
    required this.onChanged,
    required this.editHabit,
    required this.deleteHabit,
  });

  final bool isCompleted;
  final String text;
  final void Function(bool?)? onChanged;
  final void Function() editHabit;
  final void Function() deleteHabit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          if (onChanged != null) {
            onChanged!(!isCompleted);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          decoration: BoxDecoration(
            color: isCompleted ? Colors.green : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            title: Text(
              text,
              style: TextStyle(
                color: isCompleted ? Colors.white : Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            leading: Checkbox(
              activeColor: Colors.green,
              value: isCompleted,
              onChanged: onChanged,
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => editHabit(),
                    icon: const Icon(Icons.edit_outlined, size: 20),
                  ),
                  IconButton(
                    onPressed: () => deleteHabit(),
                    icon: const Icon(Icons.delete_outline, size: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
