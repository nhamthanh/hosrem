import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/notification/notification.dart' as alert;
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/conference/conference_detail.dart';
import 'package:hosrem_app/connection/connection_provider.dart';
import 'package:hosrem_app/loading/loading_indicator.dart';
import 'package:hosrem_app/survey/survey_introduction.dart';
import 'package:hosrem_app/widget/refresher/refresh_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'bloc/notifications_bloc.dart';
import 'bloc/notifications_event.dart';
import 'bloc/notifications_state.dart';
import 'notification_item.dart';
import 'notification_service.dart';

/// Notifications page.
class Notifications extends StatefulWidget {
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends BaseState<Notifications> {

  RefreshController _refreshController;
  NotificationsBloc _notificationsBloc;

  @override
  void initState() {
    super.initState();

    _notificationsBloc = NotificationsBloc(
      notificationService: NotificationService(apiProvider)
    );

    _refreshController = RefreshController();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).tr('notifications.notification')),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.playlist_add_check),
            color: Colors.white,
            onPressed: _markAllAsRead
          )
        ],
      ),
      body: ConnectionProvider(
        child: BlocProvider<NotificationsBloc>(
          builder: (BuildContext context) => _notificationsBloc,
          child: BlocListener<NotificationsBloc, NotificationsState>(
            listener: (BuildContext context, NotificationsState state) {
              if (state is NotificationsFailure) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: BlocBuilder<NotificationsBloc, NotificationsState>(
              bloc: _notificationsBloc,
              builder: (BuildContext context, NotificationsState state) {
                _refreshController.refreshCompleted();
                _refreshController.loadComplete();

                if (state is LoadedNotifications) {
                  return _buildRefreshWidget(state.notifications);
                }

                if (state is NotificationsFailure) {
                  return Center(
                    child: Text(AppLocalizations.of(context).tr('notifications.no_notification_found'))
                  );
                }

                return LoadingIndicator();
              }
            )
          )
        )
      )
    );
  }

  Widget _buildRefreshWidget(List<alert.Notification> notifications) {
    if (notifications.isNotEmpty) {
      return Container(
        child: RefreshWidget(
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            itemCount: notifications.length,
            itemBuilder: (BuildContext context, int index) {
              final alert.Notification notification = notifications[index];
              return NotificationItem(
                notification: notification,
                onTap: () => _markAsRead(notification)
              );
            },
          ),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          refreshController: _refreshController
        )
      );
    }
    return Center(
      child: Text(AppLocalizations.of(context).tr('notifications.no_notification_found'))
    );
  }

  Future<void> _markAsRead(alert.Notification notification) async {
    _notificationsBloc.dispatch(MarkAsReadEvent(notification.id));

    if (notification.notificationType == 'ConferenceUpdated') {
      final String conferenceId = notification.payload['conferenceId'];
      if (conferenceId != null) {
        await pushWidget(ConferenceDetail(conferenceId, selectedIndex: 1));
      }
    }

    if (notification.notificationType == 'ConferencePublished') {
      final String conferenceId = notification.payload['conferenceId'];
      if (conferenceId != null) {
        await pushWidget(ConferenceDetail(conferenceId));
      }
    }

    if (notification.notificationType == 'ConferenceSurvey') {
      final String conferenceId = notification.payload['conferenceId'];
      if (conferenceId != null) {
        await pushWidget(SurveyIntroduction(conferenceId));
      }
    }
  }

  void _markAllAsRead() {
    _notificationsBloc.dispatch(MarkAllAsReadEvent());
  }

  void _onLoading() {
    _notificationsBloc.dispatch(LoadMoreNotificationsEvent());
  }

  void _onRefresh() {
    _notificationsBloc.dispatch(RefreshNotificationsEvent());
  }

  @override
  void dispose() {
    _notificationsBloc.dispose();
    super.dispose();
  }
}
