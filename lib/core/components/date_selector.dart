import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kohab/core/utils/utils.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  int weekOffset = 0;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final weekDates = generateWeekDates(weekOffset);
    String monthName = DateFormat('MMMM').format(weekDates.first);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    weekOffset--;
                  });
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              Text(monthName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              IconButton(
                onPressed: () {
                  setState(() {
                    weekOffset++;
                  });
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weekDates.length,
              itemBuilder: (context, index) {
                final date = weekDates[index];
                bool isSelected = DateFormat('d').format(selectedDate) == DateFormat('d').format(date) && selectedDate.month == date.month && selectedDate.year == date.year;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: isSelected ? Theme.of(context).colorScheme.surfaceBright : Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: isSelected ? Theme.of(context).colorScheme.surfaceBright : null,
                    ),
                    margin: const EdgeInsets.only(right: 8),
                    width: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('d').format(date),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          DateFormat('E').format(date),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
