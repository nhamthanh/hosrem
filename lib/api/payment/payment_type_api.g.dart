// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_type_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _PaymentTypeApi implements PaymentTypeApi {
  _PaymentTypeApi(this._dio) {
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
        'payment-types',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = PaymentTypePagination.fromJson(_result.data);
    return Future.value(value);
  }
}
