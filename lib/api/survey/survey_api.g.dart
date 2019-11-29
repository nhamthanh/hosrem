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
  getSurvey(query) async {
    ArgumentError.checkNotNull(query, 'query');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request('surveys',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = Survey.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getQuestionsBySectionId(sectionId, query) async {
    ArgumentError.checkNotNull(sectionId, 'sectionId');
    ArgumentError.checkNotNull(query, 'query');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'surveys/$sectionId/questions',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = QuestionPagination.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  submitSurveyResult(surveyResult) async {
    ArgumentError.checkNotNull(surveyResult, 'surveyResult');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(surveyResult.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'survey-results',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = SurveyResult.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  updateSurveyResult(id, surveyResult) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(surveyResult, 'surveyResult');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(surveyResult.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'survey-results/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = SurveyResult.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getSurveyResult(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'survey-results/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = SurveyResult.fromJson(_result.data);
    return Future.value(value);
  }
}
