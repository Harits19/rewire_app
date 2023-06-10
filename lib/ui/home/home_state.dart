import 'package:init_flutter/init_flutter.dart';

class HomeState {
  final AsyncValueModel<List<DateTime>> relapseHistory;
  final Duration streak;
  final Duration longestStreak;

  HomeState({
    required this.relapseHistory,
    required this.streak,
    required this.longestStreak,
  });

  HomeState copyWith(
      {AsyncValueModel<List<DateTime>>? relapseHistory,
      Duration? streak,
      Duration? longestStreak,}) {
    return HomeState(
      relapseHistory: relapseHistory ?? this.relapseHistory,
      streak: streak ?? this.streak,
      longestStreak: longestStreak ?? this.longestStreak,
    );
  }
}
