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

  static void t(dynamic message) {
    to.t(message);
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

  static void f(dynamic message) {
    to.f(message);
  }
}
