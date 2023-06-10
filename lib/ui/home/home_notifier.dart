import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:init_flutter/init_flutter.dart';
import 'package:init_flutter/utils/my_log_util.dart';
import 'package:rewire_app/services/relapse_service.dart';
import 'package:rewire_app/ui/home/home_state.dart';

final homeNotifier = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(
    HomeState(
      relapseHistory: AsyncValueModel.initial([]),
      streak: Duration.zero,
      longestStreak: Duration.zero,
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
          final result = _relapseService.getRelapseHistory();
          return result;
        },
      ),
    );
    if (state.relapseHistory.value.isEmpty) {
      await saveRelapseHistory();
    }
  }

  Future<void> saveRelapseHistory() async {
    final tempValue = state.relapseHistory.value;
    state = state.copyWith(
      relapseHistory: state.relapseHistory.loading(),
    );
    myLog('saveRelapseHistory $dtNow');
    await _relapseService.saveRelapseHistory(
      [
        ...tempValue,
        dtNow,
      ],
    );
    getRelapseHistory();
  }

  DateTime get dtNow => DateTime.now();

  void reset() async {
    await _relapseService.saveRelapseHistory([]);
    getRelapseHistory();
  }

  void getTimeDifferent() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final relapseHistory = state.relapseHistory.value;
        if (relapseHistory.isEmpty) return;
        final longestStreak = <Duration>[];
        final streak = dtNow.difference(relapseHistory.last);
        for (int index = 0; index < relapseHistory.length; index++) {
          final item = relapseHistory[index];
          if (index == relapseHistory.length - 1) {
            longestStreak.add(dtNow.difference(item));
            continue;
          }

          longestStreak.add(relapseHistory[index + 1].difference(item));
        }
        // myLog(longestStreak);
        state = state.copyWith(
          streak: streak,
          longestStreak: Duration(
            seconds: longestStreak.map((e) => e.inSeconds).reduce(max),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
}


// [2023-06-10T21:38:51.999480, 2023-06-10T21:59:47.919008, 2023-06-10T22:10:55.314597, 2023-06-10T22:11:06.639373, 2023-06-10T22:47:28.294984]
// I/flutter (23774): [0:20:55.919528, 0:11:07.395589, 0:00:11.324776, 0:03:17.814673]