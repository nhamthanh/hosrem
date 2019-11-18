import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/conference/conference_detail.dart';
import 'package:hosrem_app/network/api_provider.dart';
import 'package:hosrem_app/survey/survey_introduction.dart';
import 'package:logging/logging.dart';

import 'notification_service.dart';

/// FCM configuration.
class FcmConfiguration {
  FcmConfiguration(this.apiProvider);

  static String conferenceSurvey = 'ConferenceSurvey';
  static String conferenceUpdated = 'ConferenceUpdated';
  static String conferencePublished = 'ConferencePublished';

  final ApiProvider apiProvider;
  final Logger _logger = Logger('FcmConfiguration');
  BuildContext _context;

  void initFcm(BuildContext context, { bool requestToken = true }) {
    _logger.info('FcmConfiguration intialized...');
    _context = context;
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    firebaseMessaging.configure(
      onMessage: _onMessage,
      onLaunch: _onLaunch,
      onResume: _onResume);

    if (requestToken) {
      firebaseMessaging
          .requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));

      firebaseMessaging.onIosSettingsRegistered.listen(_onIosSettingsRegistered);
      firebaseMessaging.getToken().then(_onToken);
    }
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
    try {
      Map<String, dynamic> data;
      if (message['data'] is String) {
        data = json.decode(message['data']);
      } else {
        data = json.decode(message['data']['data']);
      }
      if (data == null) {
        return;
      }

      final String notificationType = data['notification_type'];
      if (notificationType == null) {
        return;
      }

      await _buildAlertForConferenceNotification(notificationType, data);
    } catch (error) {
      print(error);
    }
  }

  Future<void> _buildAlertForConferenceNotification(String notificationType, Map<String, dynamic> data) async {
    if (notificationType == conferenceUpdated || notificationType == conferencePublished
        || notificationType == conferenceSurvey) {
      final String conferenceId = data['conferenceId'];
      if (conferenceId != null) {
        final String title = data['title'] ?? 'Thông Báo';
        final String message = data['message'] ?? 'Bạn có 1 thông báo mới';
        await showDialog<Set<String>>(
          context: _context,
          builder: (BuildContext context) {
            return  AlertDialog(
              title: Text(title),
              contentPadding: const EdgeInsets.all(25.0),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: const Text('ĐÓNG'),
                  onPressed: () => Navigator.pop(_context),
                ),
                FlatButton(
                  child: const Text('XEM CHI TIẾT'),
                  onPressed: () {
                    Navigator.pop(_context);
                    if (notificationType == conferenceSurvey) {
                      _navigateToConferenceSurvey(conferenceId);
                    } else {
                      _navigateToConferenceDetail(
                        conferenceId, selectedIndex: notificationType == conferencePublished ? 0 : 1);
                    }
                  }
                )
              ],
            );
          },
        );
      }
    }
  }

  Future<dynamic> _onLaunch(Map<String, dynamic> message) async {
    _logger.info('_onLaunch: $message');
  }

  Future<dynamic> _onResume(Map<String, dynamic> message) async {
    _logger.info('_onResume: $message');
    try {
      Map<String, dynamic> data;
      if (message['data'].runtimeType == 'String') {
        data = json.decode(message['data']);
      } else {
        data = json.decode(message['data']['data']);
      }

      if (data == null) {
        return;
      }

      final String notificationType = data['notification_type'];
      if (notificationType == null) {
        return;
      }

      if (notificationType == conferenceUpdated) {
        final String conferenceId = data['conferenceId'];
        if (conferenceId != null) {
          _navigateToConferenceDetail(conferenceId, selectedIndex: 1);
        }
      }

      if (notificationType == conferencePublished) {
        final String conferenceId = data['conferenceId'];
        if (conferenceId != null) {
          _navigateToConferenceDetail(conferenceId);
        }
      }

      if (notificationType == conferenceSurvey) {
        final String conferenceId = data['conferenceId'];
        if (conferenceId != null) {
          _navigateToConferenceSurvey(conferenceId);
        }
      }
    } catch (error) {
      print(error);
    }
  }

  void _navigateToConferenceDetail(String conferenceId, { int selectedIndex = 0}) {
    Navigator.push(
      _context,
      MaterialPageRoute<bool>(
        builder: (BuildContext context) => ConferenceDetail(conferenceId, selectedIndex: selectedIndex)
      )
    );
  }

  void _navigateToConferenceSurvey(String conferenceId) {
    Navigator.push(
      _context,
      MaterialPageRoute<bool>(
        builder: (BuildContext context) => SurveyIntroduction(conferenceId)
      )
    );
  }
}
