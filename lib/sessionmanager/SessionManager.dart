import 'package:flutter/material.dart';
import 'package:salessimplify/repository/Repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static SessionManager? _sessionManager;

  SessionManager._();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static String KEY_ID = "id";
  static String KEY_NAME = "name";
  static String KEY_EMAIL = "email";
  static String KEY_AUTH_TOKEN = "auth_token";
  static String KEY_UUID = "uuid";
  static String KEY_USER_EMAIL = "user_email";
  static String KEY_USER_PASS = "user_pass";
  static String KEY_ACTIVITY_LOST_REASON_SETTINGS =
      "isActivityLostReasonEnabled";
  static String KEY_ENABLE_ACTIVITY_LOST_REASON = "enable_activity_lost_reason";

  static getInstance() {
    // ignore: unnecessary_null_comparison
    if (_sessionManager == null) {
      _sessionManager = SessionManager._();
    }
    return _sessionManager;
  }

  saveProfile({
    required String id,
    required String name,
    required String emailId,
    required String authToken,
    required String uuid,
  }) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(KEY_ID, id);
    prefs.setString(KEY_NAME, name);
    prefs.setString(KEY_EMAIL, emailId);
    prefs.setString(KEY_AUTH_TOKEN, 'Bearer $authToken');
    prefs.setString(KEY_UUID, uuid);
  }

  // saveEmailPass({
  //   required String email,
  //   required String password,
  // }) async {
  //   final SharedPreferences prefs = await _prefs;

  //   prefs.setString(KEY_USER_EMAIL, email);
  //   prefs.setString(KEY_USER_PASS, password);
  // }

  getToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.get(KEY_AUTH_TOKEN);
  }

  getId() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.get(KEY_ID);
  }

  getName() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.get(KEY_NAME);
  }

  getEmailId() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.get(KEY_EMAIL);
  }

  getUuid() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.get(KEY_UUID);
  }

  activityLostReasonSetting() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(KEY_ACTIVITY_LOST_REASON_SETTINGS);
  }

  setActivityLostReasonSetting(bool flag) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(KEY_ACTIVITY_LOST_REASON_SETTINGS, flag);
  }

  clearPreferences() async {
    final SharedPreferences prefs = await _prefs;
    return await prefs.clear();
  }
}
