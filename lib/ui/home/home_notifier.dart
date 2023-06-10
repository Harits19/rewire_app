import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:init_flutter/init_flutter.dart';
import 'package:rewire_app/services/relapse_service.dart';
import 'package:rewire_app/ui/home/home_state.dart';

final homeNotifier = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(
    HomeState(
      relapseHistory: AsyncValueModel.initial([]),
    ),
    ref.watch(relapseService),
  )..getRelapseHistory();
});

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier(
    super.state,
    this._relapseService,
  );

  final RelapseService _relapseService;

  void getRelapseHistory() {
    _relapseService.getRelapseHistory();
  }
}
