import 'package:flutter/material.dart';

extension DateTimeRangeExtension on DateTimeRange {
  Map<String, dynamic> toJson() {
    return {
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
    };
  }

  DateTimeRange copyWith({DateTime? start, DateTime? end}) => DateTimeRange(
        start: start ?? this.start,
        end: end ?? this.end,
      );
}

DateTimeRange dateTimeRangeFromJson(Map<String, dynamic> json) {
  return DateTimeRange(
      start: DateTime.parse(json['start']), end: DateTime.parse(json['end']));
}
