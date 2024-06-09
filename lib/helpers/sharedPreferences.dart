// ignore: file_names
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  late SharedPreferences _prefs;

  // Private constructor
  SharedPreferencesManager._();

  // Singleton instance
  static SharedPreferencesManager? _instance;

  // Factory constructor
  static Future<SharedPreferencesManager> getInstance() async {
    _instance ??= await _initInstance();
    return _instance!;
  }

  // Initialize SharedPreferences instance
  static Future<SharedPreferencesManager> _initInstance() async {
    final manager = SharedPreferencesManager._();
    await manager._initPrefs();
    return manager;
  }

  // Initialize SharedPreferences
  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Load value from SharedPreferences
  dynamic loadValue(String key, dynamic defaultValue) {
    return _prefs.get(key) ?? defaultValue;
  }

  // Save value to SharedPreferences
  Future<bool> saveValue(String key, dynamic value) async {
    if (value is String) {
      return await _prefs.setString(key, value);
    } else if (value is int) {
      return await _prefs.setInt(key, value);
    } else if (value is double) {
      return await _prefs.setDouble(key, value);
    } else if (value is bool) {
      return await _prefs.setBool(key, value);
    } else if (value is List<String>) {
      return await _prefs.setStringList(key, value);
    } else {
      return false;
    }
  }

  // Remove value from SharedPreferences
  Future<bool> removeValue(String key) async {
    return await _prefs.remove(key);
  }
}
