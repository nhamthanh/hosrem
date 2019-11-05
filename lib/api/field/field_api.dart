import 'package:dio/dio.dart';
import 'package:hosrem_app/api/field/field_pagination.dart';
import 'package:retrofit/retrofit.dart';
part 'field_api.g.dart';

/// Field Api.
@RestApi()
abstract class FieldApi {
  factory FieldApi(Dio dio) = _FieldApi;

  /// Get fields.
  @GET('fields')
  Future<FieldPagination> getAll();

}

