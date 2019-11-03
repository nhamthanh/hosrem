// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _FieldApi implements FieldApi {
  _FieldApi(this._dio) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  @override
  getAll(query) async {
    ArgumentError.checkNotNull(query, 'query');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request('fields',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = FieldPagination.fromJson(_result.data);
    return Future.value(value);
  }
}
