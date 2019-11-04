import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hosrem_app/api/notification/notification.dart' as alert;
import 'package:hosrem_app/api/notification/notification_pagination.dart';

import 'surveys_event.dart';
import 'surveys_state.dart';

/// Surveys bloc to load surveys.
class SurveysBloc extends Bloc<SurveysEvent, SurveysState> {
  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 10;

  List<alert.Notification> notifications = <alert.Notification>[];
  NotificationPagination notificationPagination;

  @override
  SurveysState get initialState => SurveysLoading();

  @override
  Stream<SurveysState> mapEventToState(SurveysEvent event) async* {
  }
}
