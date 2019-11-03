import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'field_pagination.dart';

part 'field_api.g.dart';

/// Field Api.
@RestApi()
abstract class FieldApi {
  factory FieldApi(Dio dio) = _FieldApi;

  /// Get all fields.
  @GET('fields')
  Future<FieldPagination> getAll(@Queries() Map<String, dynamic> query);
}

