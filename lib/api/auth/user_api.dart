import 'package:dio/dio.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/conference/user_conference_pagination.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api.g.dart';

/// User Api.
@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio) = _UserApi;

  /// Get user profile.
  @GET('users/{id}')
  Future<User> getUser(@Path() String id);

  /// Update user profile.
  @PUT('users/{id}')
  Future<User> updateUser(@Path() String id, @Body() User user);


  /// Get conferences which user registered to join.
  @GET('users/{id}/registrations')
  Future<UserConferencePagination> getRegisteredConferences(@Path() String id, @Queries() Map<String, dynamic> query);
}

