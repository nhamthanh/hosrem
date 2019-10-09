import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'app_state.dart';

/// App event.
@immutable
abstract class AppEvent extends Equatable {
  const AppEvent([List<AppState> props = const <AppState>[]]) : super(props);
}

/// The event to change theme of the application.
class ChangeTheme extends AppEvent {
  ChangeTheme(this.appState) : super(<AppState>[appState]);

  final AppState appState;

  @override
  String toString() => 'Change Theme { state: $appState }';
}
