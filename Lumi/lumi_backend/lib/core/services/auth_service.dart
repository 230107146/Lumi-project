import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  static const _kUserEmail = 'lumi_user_email';
  static const _kLastRoute = 'lumi_last_route';

  // Firebase Auth instance
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Подписка на изменение состояния аутентификации.
  /// Возвращает стрим пользователей (null если не залогинен).
  static Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Проверяет, залогинен ли пользователь.
  static bool isLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  /// Возвращает текущего пользователя (если он залогинен).
  static User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  /// Вход через Google (работает на всех платформах через Firebase Auth).
  ///
  /// Для веба используется `signInWithPopup(GoogleAuthProvider())` — всплывающее окно.
  /// Для мобильных (Android/iOS) используем `google_sign_in` пакет и `signInWithCredential`.
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      // WEB: use popup so user doesn't leave the site
      if (kIsWeb) {
        // Debug log to help verify popup behaviour in browser
        // ignore: avoid_print
        print('AuthService: attempting signInWithPopup (web)');
        final provider = GoogleAuthProvider();
        // Optional scopes/parameters
        provider.addScope('email');
        provider.setCustomParameters({'prompt': 'select_account'});

        final userCredential = await _firebaseAuth.signInWithPopup(provider);
        final email = userCredential.user?.email ?? '';
        await saveUser(email);
        return userCredential;
      }

      // NATIVE (Android / iOS / desktop): use Firebase OAuth provider flow.
      // Note: you can switch to `google_sign_in` package here if you prefer the
      // native account picker flow. Using `signInWithProvider` works without
      // extra native plugin setup when Firebase is configured.
      try {
        final provider = OAuthProvider('google.com');
        final userCredential = await _firebaseAuth.signInWithProvider(provider);
        final email = userCredential.user?.email ?? '';
        await saveUser(email);
        return userCredential;
      } catch (e) {
        // Provide a helpful message if provider flow fails
        throw Exception(
            'Google Sign-In is not properly configured for native platforms. '
            'Consider enabling GoogleSignIn or configuring OAuth on the native side. Error: $e');
      }
    } on FirebaseAuthException catch (e) {
      // Include the Firebase error code and fallback to toString() when message is null
      final code = e.code;
      final message = e.message ?? e.toString();
      throw Exception('Firebase Auth Error [$code]: $message');
    } catch (e, st) {
      // Log full error and stacktrace to console for easier debugging
      // ignore: avoid_print
      print('AuthService.signInWithGoogle - unexpected error: $e');
      // ignore: avoid_print
      print(st);
      throw Exception('Google Sign-In Error: $e');
    }
  }

  /// Выход из системы (Firebase).
  static Future<void> signOut() async {
    try {
      // Выходим из Firebase
      await _firebaseAuth.signOut();
      // Очищаем локальное хранилище
      await clearUser();
    } catch (e) {
      throw Exception('Sign Out Error: $e');
    }
  }

  /// Регистрация пользователя через email/password (Firebase).
  static Future<bool> registerUser(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await saveUser(email);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return false;
      }
      rethrow;
    }
  }

  /// Валидация учетных данных (email/password) через Firebase.
  static Future<bool> validateCredentials(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await saveUser(email);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return false;
      }
      rethrow;
    }
  }

  /// Сохраняет email залогиненного пользователя в локальное хранилище.
  static Future<void> saveUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kUserEmail, email);
  }

  /// Удаляет сохраненного пользователя из локального хранилища.
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kUserEmail);
  }

  /// Возвращает сохраненный email пользователя или null.
  static Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kUserEmail);
  }

  /// Сохраняет последний маршрут (для возврата пользователя на нужную страницу).
  static Future<void> saveLastRoute(String route) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLastRoute, route);
  }

  /// Получает последний сохраненный маршрут.
  static Future<String?> getLastRoute() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kLastRoute);
  }
}
