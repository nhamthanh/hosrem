import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/network/api_provider.dart';
import 'package:logging/logging.dart';

import 'notification_service.dart';

/// FCM configuration.
class FcmConfiguration {
  FcmConfiguration(this.apiProvider);

  final ApiProvider apiProvider;
  final Logger _logger = Logger('FcmConfiguration');

  void initFcm(BuildContext context) {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    firebaseMessaging.configure(
      onMessage: _onMessage,
      onLaunch: _onLaunch,
      onResume: _onResume);

    firebaseMessaging
        .requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));

    firebaseMessaging.onIosSettingsRegistered.listen(_onIosSettingsRegistered);
    firebaseMessaging.getToken().then(_onToken);
  }

  Future<void> _onToken(String token) async {
    _logger.info('FCM Token: $token');
    final NotificationService notificationService = NotificationService(apiProvider);
    await notificationService.persistFcmToken(token);
    await notificationService.registerToken(token);
  }

  void _onIosSettingsRegistered(IosNotificationSettings settings) {
    _logger.info('Settings registered: $settings');
  }

  Future<dynamic> _onMessage(Map<String, dynamic> message) async {
    _logger.info('onMessage: $message');
  }

  Future<dynamic> _onLaunch(Map<String, dynamic> message) async {
    _logger.info('_onLaunch: $message');
  }

  Future<dynamic> _onResume(Map<String, dynamic> message) async {
    _logger.info('_onResume: $message');
  }
}
