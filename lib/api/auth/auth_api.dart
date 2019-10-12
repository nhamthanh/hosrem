import 'package:dio/dio.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:retrofit/retrofit.dart';

import 'package:hosrem_app/api/auth/token.dart';

part 'auth_api.g.dart';

/// Auth Api.
@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  /// Login with email and password in [body].
  @POST('login')
  Future<Token> login(@Body() Map<String, dynamic> body);

  /// Register a new account.
  @POST('users/register')
  Future<User> register(@Body() User user);

  /// Get current user profile.
  @GET('auth/current')
  Future<User> currentUser();
}

