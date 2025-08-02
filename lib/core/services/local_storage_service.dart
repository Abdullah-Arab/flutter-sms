import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const String _settingsBox = 'settings';
  static const String _userDataBox = 'user_data';

  Future<void> initialize() async {
    await Hive.initFlutter();
    await Hive.openBox(_settingsBox);
    await Hive.openBox(_userDataBox);
  }

  // Generic CRUD operations
  Future<void> saveData<T>(String boxName, String key, T value) async {
    final box = Hive.box(boxName);
    await box.put(key, value);
  }

  T? getData<T>(String boxName, String key) {
    final box = Hive.box(boxName);
    return box.get(key) as T?;
  }

  Future<void> deleteData(String boxName, String key) async {
    final box = Hive.box(boxName);
    await box.delete(key);
  }

  Future<void> clearBox(String boxName) async {
    final box = Hive.box(boxName);
    await box.clear();
  }

  // Settings specific methods
  Future<void> saveSetting(String key, dynamic value) async {
    await saveData(_settingsBox, key, value);
  }

  T? getSetting<T>(String key) {
    return getData<T>(_settingsBox, key);
  }

  // User data specific methods
  Future<void> saveUserData(String key, dynamic value) async {
    await saveData(_userDataBox, key, value);
  }

  T? getUserData<T>(String key) {
    return getData<T>(_userDataBox, key);
  }

  // Language preference
  Future<void> setLanguage(String languageCode) async {
    await saveSetting('language', languageCode);
  }

  String getLanguage() {
    return getSetting<String>('language') ?? 'ar';
  }

  // Theme preference
  Future<void> setThemeMode(String themeMode) async {
    await saveSetting('theme_mode', themeMode);
  }

  String getThemeMode() {
    return getSetting<String>('theme_mode') ?? 'system';
  }
}
