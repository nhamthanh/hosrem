// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conference_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ConferenceApi implements ConferenceApi {
  _ConferenceApi(this._dio) {
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
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'conferences',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = ConferencePagination.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getConferenceFees(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'conferences/$id/fees',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = ConferenceFees.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getConferenceMembers(id, query) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(query, 'query');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'conferences/$id/members',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = ConferenceMemberPagination.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getConferenceDocuments(id, query) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(query, 'query');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'conferences/$id/documents',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = DocumentPagination.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getConferenceById(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'conferences/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = Conference.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  registerConferenceById(id, user) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(user, 'user');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(user.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'conferences/$id/registrations',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = ConferenceRegistration.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  checkRegistrationStatusOfMember(id, userId) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(userId, 'userId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<bool> _result = await _dio.request(
        'conferences/$id/registrations/$userId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = _result.data;
    return Future.value(value);
  }

  @override
  getRegistrationInfoFromRegCode(id, regCode) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(regCode, 'regCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'conferences/$id/registration-codes/$regCode',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = ConferenceRegistration.fromJson(_result.data);
    return Future.value(value);
  }
}
