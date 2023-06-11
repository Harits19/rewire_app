import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  bool operator >(TimeOfDay other) {
    return inMinute() > other.inMinute();
  }

  int inMinute() {
    return (hour * 60 + minute);
  }
}
