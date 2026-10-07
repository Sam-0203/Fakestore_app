import 'package:shared_preferences/shared_preferences.dart';

class SaveToken {
  static const String _tokenKey = 'user_token';

  static const String _userIdKey = 'user_id';

  static const String _userNameKey = 'user_name';

  /// SAVE TOKEN
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_tokenKey, token);
  }

  /// GET TOKEN
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_tokenKey);
  }

  /// REMOVE TOKEN
  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_tokenKey);

    await prefs.remove(_userIdKey);

    await prefs.remove(_userNameKey);
  }

  /// CHECK TOKEN
  static Future<bool> hasToken() async {
    final token = await getToken();

    return token != null && token.isNotEmpty;
  }

  /// SAVE USER ID
  static Future<void> saveUserId(int id) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(_userIdKey, id);
  }

  /// GET USER ID
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(_userIdKey);
  }

  /// SAVE USER NAME
  static Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_userNameKey, name);
  }

  /// GET USER NAME
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_userNameKey);
  }
}
