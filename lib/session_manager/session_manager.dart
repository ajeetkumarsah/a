import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static SessionManager? _sessionManager;

  SessionManager._();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static String KEY_ID = "id";

  static String KEY_AUTH_TOKEN = "auth_token";
  static String KEY_UID = "uid";
  static String EMAIL_ID = "email_id";
  static String NAME = "name";
  static String KEY_USER_PASS = "user_pass";
  static String IS_USER_LOGGED_IN = 'user_logged_in';

  static getInstance() {
    if (_sessionManager == null) {
      _sessionManager = SessionManager._();
    }

    return _sessionManager;
  }

  saveProfile({
    required String id,
    required String authToken,
    required String name,
    required String email,
  }) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(KEY_ID, id);
    prefs.setString(EMAIL_ID, email);
    prefs.setString(NAME, name);
    prefs.setString(KEY_AUTH_TOKEN, 'Bearer $authToken');
    prefs.setBool(IS_USER_LOGGED_IN, true);
  }

  getToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.get(KEY_AUTH_TOKEN);
  }

  getId() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.get(KEY_ID);
  }

  getEmail() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.get(EMAIL_ID);
  }

  getName() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.get(NAME);
  }

  getIsUserLoggedIn() async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getBool(IS_USER_LOGGED_IN);
  }

  getUuid() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.get(KEY_UID);
  }

  clearPreferences() async {
    final SharedPreferences prefs = await _prefs;
    return await prefs.clear();
  }
}
