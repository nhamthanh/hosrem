import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';

/// Application bloc delegate to track all transition between pages.
class AppBlocDelegate extends BlocDelegate {
  AppBlocDelegate() : super() {
    _logger = Logger('AppBlocDelegate');
  }

  Logger _logger;

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    _logger.info(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc<dynamic, dynamic> bloc, Object error, StackTrace stacktrace) {
    _logger.fine(error);
    print(stacktrace);
    super.onError(bloc, error, stacktrace);
  }
}
