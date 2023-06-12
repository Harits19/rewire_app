import 'package:flutter/material.dart';
import 'package:init_flutter/init_flutter.dart';
import 'package:rewire_app/extensions/duration_extension.dart';

class HomeState {
  final AsyncValueModel<List<DateTimeRange>> relapseHistory;

  HomeState({
    required this.relapseHistory,
  });

  HomeState copyWith({
    AsyncValueModel<List<DateTimeRange>>? relapseHistory,
  }) {
    return HomeState(
      relapseHistory: relapseHistory ?? this.relapseHistory,
    );
  }

  Duration get longestStreak =>
      relapseHistory.value.map((e) => e.duration).toList().biggest();

  Duration get streak => (relapseHistory.value.isNotEmpty
      ? DateTime.now().difference(relapseHistory.value.last.start)
      : Duration.zero);
}
