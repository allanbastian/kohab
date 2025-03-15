List<DateTime> generateWeekDates(int weekOffset) {
  final today = DateTime.now();
  DateTime startOfWeek = today.subtract(Duration(days: today.weekday-1));
  startOfWeek = startOfWeek.add(Duration(days: weekOffset * 7 * 24 * 60 * 60 * 1000));
  return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
}