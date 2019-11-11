// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _UserApi implements UserApi {
  _UserApi(this._dio) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  @override
  getUser(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'users/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = User.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  updateUser(id, user) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(user, 'user');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(user.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'users/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = User.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  updateUserPassword(id, userPassword) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(userPassword, 'userPassword');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(userPassword.toJson() ?? <String, dynamic>{});
    final Response<bool> _result = await _dio.request('users/$id/password',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = _result.data;
    return Future.value(value);
  }

  @override
  getRegisteredConferences(id, query) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(query, 'query');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'users/$id/registrations',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = UserConferencePagination.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getUserNotifications(id, query) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(query, 'query');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'users/$id/notifications',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = NotificationPagination.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  markAsRead(id, notificationId) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(notificationId, 'notificationId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<void> _result = await _dio.request(
        'users/$id/notifications/$notificationId/read',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    return Future.value(null);
  }

  @override
  markAllAsRead(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<void> _result = await _dio.request(
        'users/$id/notifications/read-all',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    return Future.value(null);
  }
}
