import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/app/app_context.dart';
import 'package:hosrem_app/app/bloc/app_bloc.dart';
import 'package:hosrem_app/config/api_config.dart';
import 'package:hosrem_app/db/app_database.dart';
import 'package:hosrem_app/network/api_provider.dart';
import 'package:hosrem_app/notification/fcm_configuration.dart';
import 'package:page_transition/page_transition.dart';

/// Base state widget.
abstract class BaseState<T extends StatefulWidget> extends State<T> {

  AppContext _appContext;

  @override
  void initState() {
    super.initState();
    onResumeWidget();
  }

  /// Resume the widget when user the active widget is pop.
  @protected
  void onResumeWidget() {
    final FcmConfiguration fcmConfiguration = BlocProvider.of<AppBloc>(context).appContext.fcmConfiguration;
    fcmConfiguration.initFcm(context, requestToken: false);
  }

  /// Navigate to the widget [widget].
  @protected
  Future<void> pushWidget(Widget widget) async {
    await Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => widget));
    onResumeWidget();
  }

  /// Navigate to the widget [widget] and waiting for the result.
  @protected
  Future<bool> pushWidgetWithBoolResult(Widget widget) async {
    final bool result = await Navigator.push(context, MaterialPageRoute<bool>(builder: (BuildContext context) => widget));
    onResumeWidget();
    return result;
  }

  /// Navigate to the widget with transition [type].
  @protected
  Future<void> pushWidgetWithTransition(Widget widget, PageTransitionType type) async {
    await Navigator.push<void>(context, PageTransition<void>(
      type: type,
      child: widget
    ));
    onResumeWidget();
  }

  /// Navigate to the widget with transition [type] and waiting for the result.
  @protected
  Future<bool> pushWidgetWithTransitionResult(Widget widget, PageTransitionType type) async {
    final bool result = await Navigator.push<bool>(context, PageTransition<bool>(
      type: type,
      child: widget
    ));
    onResumeWidget();
    return result;
  }

  /// Get application context.
  AppContext get appContext {
    _appContext ??= BlocProvider.of<AppBloc>(context).appContext;
    return _appContext;
  }

  /// Get router.
  Router get router {
    return appContext.router;
  }

  /// Get api provider.
  ApiProvider get apiProvider {
    return appContext.apiProvider;
  }

  /// Get api configuration.
  ApiConfig get apiConfig {
    return appContext.apiConfig;
  }

  /// Get database manager.
  AppDatabase get appDatabase {
    return appContext.appDatabase;
  }
}


