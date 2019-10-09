import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:hosrem_app/api/auth/user.dart';

part 'user_api.g.dart';

/// User Api.
@RestApi(baseUrl: 'https://api.hosrem-dev.zamo.io/api/')
abstract class UserApi {
  factory UserApi(Dio dio) = _UserApi;

  /// Update user profile.
  @POST('users/{id}')
  Future<User> updateUser(@Path() String id, @Body() Map<String, dynamic> body);
}

