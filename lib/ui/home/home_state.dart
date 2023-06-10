import 'package:init_flutter/init_flutter.dart';

class HomeState {
  final AsyncValueModel<List<DateTime>> relapseHistory;
  final Duration timeDifferent;

  HomeState({required this.relapseHistory, required this.timeDifferent});

  HomeState copyWith({
    AsyncValueModel<List<DateTime>>? relapseHistory,
    Duration? timeDifferent
  }) {
    return HomeState(
      relapseHistory: relapseHistory ?? this.relapseHistory,
      timeDifferent: timeDifferent ?? this.timeDifferent,
    );
  }
}
