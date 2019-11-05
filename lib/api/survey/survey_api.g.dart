// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _SurveyApi implements SurveyApi {
  _SurveyApi(this._dio) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  @override
  getSurvey(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'conferences/c0a8e004-6dc3-1f74-816d-c4342d770000/fees',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = Survey.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getAllQuestions(query) async {
    ArgumentError.checkNotNull(query, 'query');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'conferences',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = QuestionPagination.fromJson(_result.data);
    return Future.value(value);
  }
}
