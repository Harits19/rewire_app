


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:init_flutter/enum/bot_nav_enum.dart';

final bottomNavigationNotifier = StateProvider<BotNavEnum>((ref) {
  return BotNavEnum.values.first;
});