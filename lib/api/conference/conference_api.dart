import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:hosrem_app/api/conference/conference_pagination.dart';

import 'conference_resource_pagination.dart';

part 'conference_api.g.dart';

/// Conference Api.
@RestApi()
abstract class ConferenceApi {
  factory ConferenceApi(Dio dio) = _ConferenceApi;

  /// Get all conferences.
  @GET('manufactures')
//  @GET('conferences')
  Future<ConferencePagination> getAll(@Queries() Map<String, dynamic> query);

  @GET('manufactures')
//  @GET('conferences')
  Future<ConferenceResourcePagination> getAllConferenceResources(@Queries() Map<String, dynamic> query);
}

