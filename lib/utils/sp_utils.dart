import 'package:shared_preferences/shared_preferences.dart';

/// @author: xiao
/// created on: 2025/7/16 16:17
/// description:

class SpUtils {
  SpUtils._();

  static Future<bool> save<T>(String key, T value) async {
    final prefs = await SharedPreferences.getInstance();
    switch (T) {
      case String:
        return prefs.setString(key, value as String);
      case int:
        return prefs.setInt(key, value as int);
      case bool:
        return prefs.setBool(key, value as bool);
      case double:
        return prefs.setDouble(key, value as double);
      case const (List<String>):
        return prefs.setStringList(key, value as List<String>);
      default:
        throw Exception('Unsupported type');
    }
  }

  static Future<T?> get<T>(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic value;
    if (T == String) {
      value = prefs.getString(key);
    } else if (T == int) {
      value = prefs.getInt(key);
    } else if (T == bool) {
      value = prefs.getBool(key);
    } else if (T == double) {
      value = prefs.getDouble(key);
    } else if (T == List) {
      value = prefs.getStringList(key);
    }
    return value as T?;
  }
}
