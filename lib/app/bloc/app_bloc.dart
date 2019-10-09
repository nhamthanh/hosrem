import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hosrem_app/app/app_context.dart';
import 'app_event.dart';
import 'app_state.dart';

/// App bloc.
class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this.appContext) : assert(appContext != null);

  final AppContext appContext;

  @override
  AppState get initialState => AppState.light;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {}
}
