import 'dart:convert';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:hosrem_app/api/auth/token.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/network/api_provider.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Authentication service.
class AuthService {
  AuthService(this.apiProvider);

  final ApiProvider apiProvider;

  /// Authenticate via [email] and [password] and return a authenticated token.
  Future<String> authenticate({
    @required String email,
    @required String password
  }) async {
    final Token tokenObj = await apiProvider.authApi.login(<String, String>{
      'email': email,
      'password': password
    });
    return tokenObj.token;
  }

  /// Delete token when logout.
  Future<void> deleteToken() async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.remove('token');
  }

  /// Persist [token] into shared preferences.
  Future<void> persistToken(String token) async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setString('token', token);
  }

  /// Check if token exists in shared preferences.
  Future<bool> hasToken() async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    final String token = _sharedPreferences.getString('token');
    return token != null && token.isNotEmpty;
  }

  /// Login with Facebook account.
  Future<String> loginWithFacebook() async {
    final FacebookLogin facebookLogin = FacebookLogin();
    final FacebookLoginResult result = await facebookLogin.logIn(<String>['email']);

    if (result.status == FacebookLoginStatus.loggedIn) {
      return 'jwttoken';
    }

    return 'jwttoken';
  }

  /// Load current user.
  Future<User> loadCurrentUser() async {
//    return apiProvider.authApi.currentUser();
    await Future<String>.delayed(Duration(seconds: 1));
    return User(
      'An',
      'Le',
      'An Le',
      'an.le@zamo.io',
      '',
      'Active',
      'Staff',
      'Doctor',
      'Hosrem',
      null
    );
  }

  /// Persist [user] into shared preferences.
  Future<void> persistCurrentUser(User user) async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setString('currentUser', jsonEncode(user.toJson()));
  }

  /// Get current user.
  Future<User> currentUser() async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    final String currentUser = _sharedPreferences.getString('currentUser');
    return User.fromJson(jsonDecode(currentUser));
  }

  /// Register a new account using [email] and [password].
  Future<User> signUp(User user) async {
    return apiProvider.authApi.register(user);
  }

  /// Update user profile via [user].
  Future<bool> updateProfile(User user) async {
    await Future<String>.delayed(Duration(seconds: 1));
    return true;
  }
}
