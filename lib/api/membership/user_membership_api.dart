import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'user_membership.dart';

part 'user_membership_api.g.dart';

/// User membership Api.
@RestApi()
abstract class UserMembershipApi {
  factory UserMembershipApi(Dio dio) = _UserMembershipApi;

  /// Get user membership of [userId].
  @GET('user-memberships/{userId}')
  Future<UserMembership> getMembershipStatusByUserId(@Path() String userId);

  /// Create user membership via [userMembership].
  @POST('user-memberships')
  Future<UserMembership> createUserMembership(@Body() UserMembership userMembership);
}

