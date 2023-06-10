


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rewire_app/enum/bot_nav_enum.dart';

final bottomNavigationNotifier = StateProvider<BotNavEnum>((ref) {
  return BotNavEnum.values.first;
});