import 'package:dio/dio.dart';
import 'package:hosrem_app/api/auth/forgot_password.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/auth/user_password.dart';
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

  /// Login with oAuthProvider in [body].
  @POST('login/{oAuthProvider}')
  Future<Token> loginOauthProvider(@Path() String oAuthProvider, @Body() Map<String, dynamic> body);

  /// Register a new account.
  @POST('users/register')
  Future<User> register(@Body() User user);

  /// Get current user profile.
  @GET('auth/current')
  Future<User> currentUser();

  /// Generate varify code by email.
  @POST('security/passwords/gen-validation-code')
  Future<void> forgotPassword(@Body() ForgotPassword forgotPassword);

  /// Verify reset password code.
  @POST('security/checking-validation-code/{vc}')
  Future<bool> verifyResetPasswordCode(@Path() String vc);

  /// Change user password when forgot .
  @POST('security/passwords/reset-forgot')
  Future<bool> resetUserPassword(@Body() UserPassword userPassword);
}

