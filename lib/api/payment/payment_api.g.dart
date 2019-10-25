// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _PaymentApi implements PaymentApi {
  _PaymentApi(this._dio) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  @override
  createPayment(payment) async {
    ArgumentError.checkNotNull(payment, 'payment');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(payment.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'payments',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST', headers: <String, dynamic>{}, extra: _extra),
        data: _data);
    final value = Payment.fromJson(_result.data);
    return Future.value(value);
  }
}
