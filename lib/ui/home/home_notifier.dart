import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:init_flutter/init_flutter.dart';
import 'package:rewire_app/services/relapse_service.dart';
import 'package:rewire_app/ui/home/home_state.dart';

final homeNotifier = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(
    HomeState(
      relapseHistory: AsyncValueModel.initial([]),
      timeDifferent: Duration.zero,
    ),
    ref.watch(relapseService),
  )
    ..getRelapseHistory()
    ..getTimeDifferent();
});

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier(
    super.state,
    this._relapseService,
  );

  final RelapseService _relapseService;
  Timer? timer;

  void getRelapseHistory() async {
    state = state.copyWith(
      relapseHistory: await state.relapseHistory.guard(
        () async {
          return _relapseService.getRelapseHistory();
        },
      ),
    );
  }

  void saveRelapseHistory() {
    _relapseService.saveRelapseHistory(
      [
        ...state.relapseHistory.value,
        DateTime.now(),
      ],
    );
    getRelapseHistory();
  }

  void getTimeDifferent() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final relapseHistory = state.relapseHistory.value;
        if (relapseHistory.isEmpty) return;
        state = state.copyWith(
            timeDifferent: DateTime.now().difference(relapseHistory.last));
      },
    );
  }
}
