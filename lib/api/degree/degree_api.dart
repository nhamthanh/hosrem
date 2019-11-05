import 'package:dio/dio.dart';
import 'package:hosrem_app/api/degree/degree_pagination.dart';
import 'package:retrofit/retrofit.dart';
part 'degree_api.g.dart';

/// Degree Api.
@RestApi()
abstract class DegreeApi {
  factory DegreeApi(Dio dio) = _DegreeApi;

  /// Get all degrees.
  @GET('degrees')
  Future<DegreePagination> getAll();
}