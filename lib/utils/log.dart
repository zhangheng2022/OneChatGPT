import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger(
    printer: PrefixPrinter(
      PrettyPrinter(
        methodCount: 2, // Number of method calls to be displayed
        errorMethodCount: 8, // Number of method calls if stacktrace is provided
        lineLength: 120, // Width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        dateTimeFormat: DateTimeFormat.dateAndTime,
      ),
    ),
  );

  static void t(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    _logger.t({message, error, stackTrace, time});
  }

  static void d(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    _logger.d({message, error, stackTrace, time});
  }

  static void i(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    _logger.i({message, error, stackTrace, time});
  }

  static void w(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    _logger.w({message, error, stackTrace, time});
  }

  static void e(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    _logger.e({message, error, stackTrace, time});
  }

  static void f(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    _logger.f({message, error, stackTrace, time});
  }
}
