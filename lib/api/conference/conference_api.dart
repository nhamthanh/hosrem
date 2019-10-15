import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:hosrem_app/api/conference/conference_pagination.dart';

part 'conference_api.g.dart';

/// Conference Api.
@RestApi()
abstract class ConferenceApi {
  factory ConferenceApi(Dio dio) = _ConferenceApi;

  /// Get all conferences.
  @GET('conferences')
  Future<ConferencePagination> getAll(@Queries() Map<String, dynamic> query);
}

