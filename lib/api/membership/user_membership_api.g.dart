// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_membership_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _UserMembershipApi implements UserMembershipApi {
  _UserMembershipApi(this._dio) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  @override
  createUserMembership(userMembership) async {
    ArgumentError.checkNotNull(userMembership, 'userMembership');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(userMembership.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'user-memberships',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = UserMembership.fromJson(_result.data);
    return Future.value(value);
  }
}
