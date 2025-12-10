import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _kUserEmail = 'lumi_user_email';
  static const _kUsers = 'lumi_users';
  static const _kLastRoute = 'lumi_last_route';

  /// Save the logged-in user's email to local storage.
  static Future<void> saveUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kUserEmail, email);
  }

  /// Remove saved user (log out) — does NOT delete registered accounts.
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kUserEmail);
  }

  /// Return current saved user email or null.
  static Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kUserEmail);
  }

  /// Quick check if user is logged in.
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_kUserEmail);
  }

  /// Register a user locally (email -> password). Returns false if user exists.
  static Future<bool> registerUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kUsers);
    final Map<String, String> users =
        raw == null ? {} : Map<String, String>.from(json.decode(raw) as Map);
    if (users.containsKey(email)) return false;
    users[email] = password;
    await prefs.setString(_kUsers, json.encode(users));
    return true;
  }

  /// Validate credentials against stored users.
  static Future<bool> validateCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kUsers);
    if (raw == null) return false;
    final users = Map<String, String>.from(json.decode(raw) as Map);
    return users[email] == password;
  }

  /// Save last route visited (for returning the user where they were).
  static Future<void> saveLastRoute(String route) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLastRoute, route);
  }

  static Future<String?> getLastRoute() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kLastRoute);
  }
}
