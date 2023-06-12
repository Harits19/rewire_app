import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:init_flutter/utils/my_log_util.dart';
import 'package:rewire_app/enum/shared_pref_enum.dart';
import 'package:rewire_app/extensions/date_time_range.dart';
import 'package:rewire_app/services/shared_pref_service.dart';

final relapseService = Provider<RelapseService>((ref) {
  return RelapseService(ref.watch(sharedPrefService));
});

class RelapseService {
  RelapseService(this.sharedPrefService);

  final SharedPrefService sharedPrefService;
  Future<void> saveRelapseHistory(List<DateTimeRange> list) async {
    final encode = jsonEncode(list.map((e) => e.toJson()).toList());
    myLog(encode);
    await sharedPrefService.pref.setString(
      SharedPrefEnum.relapseHistory.name,
      encode,
    );
  }

  List<DateTimeRange> getRelapseHistory() {
    final result = sharedPrefService.pref.getString(
      SharedPrefEnum.relapseHistory.name,
    );
    if (result == null) return [];
    final decode = jsonDecode(result);
    myLog(decode);
    if (decode is! List) throw 'Wrong data type';
    return decode.map((e) => dateTimeRangeFromJson(e)).toList();
  }
}
