import 'package:flutter/material.dart';

extension DateTimeExtension on List<DateTime> {
  List<Duration> getDifferent() {
    final longestStreak = <Duration>[];

    for (int index = 0; index < length; index++) {
      final item = this[index];
      if (index == length - 1) {
        longestStreak.add(DateTime.now().difference(item));
        continue;
      }

      longestStreak.add(this[index + 1].difference(item));
    }
    return longestStreak;
  }

  List<DateTimeRange> toDateRange() {
    final dateRange = <DateTimeRange>[];

    for (int index = 0; index < length; index++) {
      final item = this[index];
      if (index == length - 1) {
        dateRange.add(DateTimeRange(
          start: item,
          end: DateTime.now(),
        ));
        continue;
      }

      dateRange.add(
        DateTimeRange(
          start: item,
          end: this[index + 1],
        ),
      );
    }
    return dateRange;
  }
}
