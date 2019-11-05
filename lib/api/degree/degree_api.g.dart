// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'degree_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _DegreeApi implements DegreeApi {
  _DegreeApi(this._dio) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  @override
  getAll() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request('degrees',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = DegreePagination.fromJson(_result.data);
    return Future.value(value);
  }
}
