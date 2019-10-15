import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'document_pagination.dart';

part 'document_api.g.dart';

/// Document Api.
@RestApi()
abstract class DocumentApi {
  factory DocumentApi(Dio dio) = _DocumentApi;

  /// Get all documents.
  @GET('documents')
  Future<DocumentPagination> getAll(@Queries() Map<String, dynamic> query);
}

