import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _lockCountKey = 'lock_count';
  static const String _todayCountKey = 'today_count';
  static const String _lastDateKey = 'last_date';
  static const String _showClockKey = 'show_clock';
  static const String _showDateKey = 'show_date';
  static const String _autoLockKey = 'auto_lock';

  // Statistika
  static Future<int> getTotalLocks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_lockCountKey) ?? 0;
  }

  static Future<int> getTodayLocks() async {
    final prefs = await SharedPreferences.getInstance();
    final today = _todayString();
    final lastDate = prefs.getString(_lastDateKey);

    if (lastDate != today) {
      await prefs.setString(_lastDateKey, today);
      await prefs.setInt(_todayCountKey, 0);
      return 0;
    }
    return prefs.getInt(_todayCountKey) ?? 0;
  }

  static Future<void> incrementLocks() async {
    final prefs = await SharedPreferences.getInstance();
    final total = prefs.getInt(_lockCountKey) ?? 0;
    await prefs.setInt(_lockCountKey, total + 1);

    final today = _todayString();
    final lastDate = prefs.getString(_lastDateKey);
    if (lastDate != today) {
      await prefs.setString(_lastDateKey, today);
      await prefs.setInt(_todayCountKey, 1);
    } else {
      final todayCount = prefs.getInt(_todayCountKey) ?? 0;
      await prefs.setInt(_todayCountKey, todayCount + 1);
    }
  }

  static Future<void> resetStats() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lockCountKey, 0);
    await prefs.setInt(_todayCountKey, 0);
  }

  // Parametrlər
  static Future<bool> getShowClock() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_showClockKey) ?? true;
  }

  static Future<void> setShowClock(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_showClockKey, value);
  }

  static Future<bool> getShowDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_showDateKey) ?? true;
  }

  static Future<void> setShowDate(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_showDateKey, value);
  }

  static Future<bool> getAutoLock() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_autoLockKey) ?? false;
  }

  static Future<void> setAutoLock(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_autoLockKey, value);
  }

  static String _todayString() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }
}
