import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Api configuration.
@immutable
class ApiConfig {
  const ApiConfig({
    @required this.appName,
    @required this.flavorName,
    @required this.apiBaseUrl
  });

  final String appName;
  final String flavorName;
  final String apiBaseUrl;
}
