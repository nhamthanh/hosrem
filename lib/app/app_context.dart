import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/config/api_config.dart';
import 'package:hosrem_app/db/app_database.dart';
import 'package:hosrem_app/network/api_provider.dart';

/// App context to store configurations and variables for router, database, API of the application.
@immutable
class AppContext {
  const AppContext({
    @required this.router,
    @required this.appDatabase,
    @required this.apiConfig,
    @required this.apiProvider,
  })  : assert(router != null),
        assert(appDatabase != null),
        assert(apiConfig != null),
        assert(apiProvider != null);

  final Router router;
  final AppDatabase appDatabase;
  final ApiConfig apiConfig;
  final ApiProvider apiProvider;
}
