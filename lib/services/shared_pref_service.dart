import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefService = Provider<SharedPrefService>((ref) {
  return SharedPrefService();
});

class SharedPrefService {
  late final SharedPreferences _prefs;

  SharedPreferences get pref => _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }




}
