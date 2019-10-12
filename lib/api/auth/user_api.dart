import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:hosrem_app/api/auth/user.dart';

part 'user_api.g.dart';

/// User Api.
@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio) = _UserApi;

  /// Get user profile.
  @GET('users/{id}')
  Future<User> getUser(@Path() String id);
}

