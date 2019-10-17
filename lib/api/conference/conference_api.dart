import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'conference_fees.dart';
import 'conference_member_pagination.dart';
import 'conference_pagination.dart';

part 'conference_api.g.dart';

/// Conference Api.
@RestApi()
abstract class ConferenceApi {
  factory ConferenceApi(Dio dio) = _ConferenceApi;

  /// Get all conferences.
  @GET('conferences')
  Future<ConferencePagination> getAll(@Queries() Map<String, dynamic> query);

  /// Get all conference fees.
  @GET('conferences/{id}/fees')
  Future<ConferenceFees> getConferenceFees(@Path() String id);

  /// Get all conference fees.
  @GET('conferences/{id}/members')
  Future<ConferenceMemberPagination> getConferenceMembers(@Path() String id, @Queries() Map<String, dynamic> query);
}

