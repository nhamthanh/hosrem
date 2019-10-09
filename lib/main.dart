import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/logger/logger.dart';

import 'app/app.dart';
import 'config/api_config.dart';

void main() {
  initLogger();

  const ApiConfig apiConfig = ApiConfig(
    appName: 'Build flavors DEV',
    flavorName: 'dev',
    apiBaseUrl: 'https://api.vulcan-dev.dabridal.com/api/v1/',
  );

  runApp(EasyLocalization(child: const App(apiConfig: apiConfig)));
}
