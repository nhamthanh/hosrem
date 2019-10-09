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
  @POST('auth/login')
  Future<Token> login(@Body() Map<String, dynamic> body);

  /// Register a new account.
//  @POST('auth/register')
  @POST('https://api.hosrem-dev.zamo.io/api/users')
  Future<User> register(@Body() User user);

  /// Get current user profile.
  @GET('auth/current')
  Future<User> currentUser();
}

