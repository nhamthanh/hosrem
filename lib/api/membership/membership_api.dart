import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'membership_pagination.dart';

part 'membership_api.g.dart';

/// Membership Api.
@RestApi()
abstract class MembershipApi {
  factory MembershipApi(Dio dio) = _MembershipApi;

  /// Get all memberships.
  @GET('memberships')
  Future<MembershipPagination> getAll(@Queries() Map<String, dynamic> query);
}

