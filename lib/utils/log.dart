import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger(
    printer: PrefixPrinter(
      PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.dateAndTime,
      ),
    ),
  );

  static void _log(
    Level level,
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    switch (level) {
      case Level.trace:
        _logger.t({message, error, stackTrace, time});
      case Level.debug:
        _logger.d({message, error, stackTrace, time});
      case Level.info:
        _logger.i({message, error, stackTrace, time});
      case Level.warning:
        _logger.w({message, error, stackTrace, time});
      case Level.error:
        _logger.e({message, error, stackTrace, time});
      case Level.fatal:
        _logger.f({message, error, stackTrace, time});
      default:
        _logger.i({message, error, stackTrace, time});
    }
  }

  static void t(dynamic message,
          {Object? error, StackTrace? stackTrace, DateTime? time}) =>
      _log(Level.trace, message,
          error: error, stackTrace: stackTrace, time: time);

  static void d(dynamic message,
          {Object? error, StackTrace? stackTrace, DateTime? time}) =>
      _log(Level.debug, message,
          error: error, stackTrace: stackTrace, time: time);

  static void i(dynamic message,
          {Object? error, StackTrace? stackTrace, DateTime? time}) =>
      _log(Level.info, message,
          error: error, stackTrace: stackTrace, time: time);

  static void w(dynamic message,
          {Object? error, StackTrace? stackTrace, DateTime? time}) =>
      _log(Level.warning, message,
          error: error, stackTrace: stackTrace, time: time);

  static void e(dynamic message,
          {Object? error, StackTrace? stackTrace, DateTime? time}) =>
      _log(Level.error, message,
          error: error, stackTrace: stackTrace, time: time);

  static void f(dynamic message,
          {Object? error, StackTrace? stackTrace, DateTime? time}) =>
      _log(Level.fatal, message,
          error: error, stackTrace: stackTrace, time: time);
}
