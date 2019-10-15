import 'dart:convert';
import 'dart:typed_data';

import 'package:corsac_jwt/corsac_jwt.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:hosrem_app/api/auth/token.dart';
import 'package:hosrem_app/api/auth/token_payload.dart';
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
      'username': email,
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
  Future<void> persistToken(String token, {String email, String password}) async {
    final JWT decodedToken = JWT.parse(token);
    final Uint8List payloadList = base64.decode(base64.normalize(decodedToken.encodedPayload));
    final TokenPayload tokenPayload = TokenPayload.fromJson(jsonDecode(String.fromCharCodes(payloadList)));
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setString('token', token);
    await _sharedPreferences.setString('id', tokenPayload.id);
    if (email != null) {
      await _sharedPreferences.setString('email', email);
    }
    if (password != null) {
      await _sharedPreferences.setString('password', password);
    }
  }

  /// Get authentication token.
  Future<String> getToken() async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString('token');
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
    await facebookLogin.logIn(<String>['email']);
//    if (result.status == FacebookLoginStatus.loggedIn) {
//      return 'jwttoken';
//    }
//    return 'jwttoken';

    throw Exception('Chưa hỗ trợ để đăng nhập với Facebook');
  }

  /// Load current user.
  Future<User> loadCurrentUser() async {
    await Future<String>.delayed(Duration(seconds: 1));
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    return apiProvider.userApi.getUser(_sharedPreferences.get('id'));
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

  /// Clear authentication.
  Future<void> clearUser() async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.remove('token');
    await _sharedPreferences.remove('currentUser');
    await _sharedPreferences.remove('email');
    await _sharedPreferences.remove('password');
  }
}
