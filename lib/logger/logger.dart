import 'package:hosrem_app/network/api_exception.dart';
import 'package:logging/logging.dart';

/// Init logger.
void initLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord record) {
    final dynamic e = record.error;
    final String m = e is ApiException ? e.message : e.toString();
    print(
      '${record.loggerName}: ${record.level.name}: ${record.message} ${m != 'null' ? m : ''}');
  });

  Logger.root.info('Logger initialized.');
}
