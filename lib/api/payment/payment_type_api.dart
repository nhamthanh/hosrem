import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'payment_type_pagination.dart';

part 'payment_type_api.g.dart';

/// Payment type Api.
@RestApi()
abstract class PaymentTypeApi {
  factory PaymentTypeApi(Dio dio) = _PaymentTypeApi;

  /// Get all payment types.
  @GET('payment-types')
  Future<PaymentTypePagination> getAll(@Queries() Map<String, dynamic> query);
}

