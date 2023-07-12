import 'package:logger/logger.dart';

class Log {
  late Logger _logger;

  Log._internal() {
    _logger = Logger(
      printer: PrettyPrinter(
        errorMethodCount: 3,
        printEmojis: true,
        methodCount: 0,
      ),
    );
  }

  static Logger to = _instance._logger;

  factory Log() => _instance;

  static final Log _instance = Log._internal();

  static void v(dynamic message) {
    to.v(message);
  }

  static void d(dynamic message) {
    to.d(message);
  }

  static void i(dynamic message) {
    to.i(message);
  }

  static void w(dynamic message) {
    to.w(message);
  }

  static void e(dynamic message) {
    to.e(message);
  }

  static void wtf(dynamic message) {
    to.wtf(message);
  }

  static void _logByLevel(Level logLevel, String message) {
    switch (logLevel) {
      case Level.info:
        to.i(message);
        break;
      case Level.warning:
        to.w(message);
        break;

      case Level.error:
        to.e(message);
        break;
      default:
        throw UnimplementedError();
    }
  }
}
