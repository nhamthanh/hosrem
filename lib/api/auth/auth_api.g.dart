// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _AuthApi implements AuthApi {
  _AuthApi(this._dio) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  @override
  login(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request('login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = Token.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  register(user) async {
    ArgumentError.checkNotNull(user, 'user');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(user.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'users/register',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = User.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  currentUser() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'auth/current',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = User.fromJson(_result.data);
    return Future.value(value);
  }
}
