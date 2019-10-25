import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Api configuration.
@immutable
class ApiConfig {
  const ApiConfig({
    @required this.appName,
    @required this.flavorName,
    @required this.apiBaseUrl,
    @required this.momoMerchantName,
    @required this.momoMerchantCode,
    @required this.momoPartnerCode,
    @required this.momoAppScheme
  });

  final String appName;
  final String flavorName;
  final String apiBaseUrl;
  final String momoMerchantName;
  final String momoMerchantCode;
  final String momoPartnerCode;
  final String momoAppScheme;
}
