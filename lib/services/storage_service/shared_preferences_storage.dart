import 'package:shared_preferences/shared_preferences.dart';

import 'storage_service.dart';


class SharedPreferencesStorage extends StorageService {
  static const timeLeftKey = 'time_left';

  @override
  Future<int?> getTimeLeft() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(timeLeftKey);
  }

  @override
  Future<void> saveTimeLeft(int seconds) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(timeLeftKey, seconds);
  }
}
