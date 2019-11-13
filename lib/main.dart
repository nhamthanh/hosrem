import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/logger/logger.dart';

import 'app/app.dart';
import 'config/api_config.dart';

/// Main application.
void main() {
  initLogger();

  const ApiConfig apiConfig = ApiConfig(
    appName: 'Hosrem',
    flavorName: 'dev',
    apiBaseUrl: 'https://api.hosrem-dev.zamo.io/api/',
    momoMerchantName: 'Zamo LLC',
    momoMerchantCode: 'MOMOS9HI20191019',
    momoPartnerCode: 'MOMOS9HI20191019',
    momoAppScheme: 'momos9hi20191019'
  );

  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runApp(EasyLocalization(child: const App(apiConfig: apiConfig)));
}
