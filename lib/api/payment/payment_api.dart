import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'payment.dart';

part 'payment_api.g.dart';

/// Payment Api.
@RestApi()
abstract class PaymentApi {
  factory PaymentApi(Dio dio) = _PaymentApi;

  /// Create a new payment via [payment].
  @POST('payments')
  Future<Payment> createPayment(@Body() Payment payment);
}

