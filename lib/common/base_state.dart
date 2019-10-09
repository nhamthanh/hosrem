import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/app/app_context.dart';
import 'package:hosrem_app/app/bloc/app_bloc.dart';
import 'package:hosrem_app/db/app_database.dart';
import 'package:hosrem_app/network/api_provider.dart';

/// Base state widget.
abstract class BaseState<T extends StatefulWidget> extends State<T> {

  AppContext _appContext;

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

  /// Get database manager.
  AppDatabase get appDatabase {
    return appContext.appDatabase;
  }
}


