import 'package:logger/logger.dart';

class DebugLogger {
  
  static final DebugLogger _debugLogger = DebugLogger._();
  static late Logger _logger;

  static DebugLogger get log => _debugLogger;

  DebugLogger._() {
    Logger.level = Level.debug;
    _logger = Logger();
  }

  void logD(message, [Object? error, StackTrace? stackTrace]) {
    return _logger.d(message, error: error, stackTrace: stackTrace);
  }

  void logE(message, {Object? error, StackTrace? stackTrace}) {
    return _logger.e(message, error: error, stackTrace: stackTrace);
  }

  void logI(message, [Object? error, StackTrace? stackTrace]) {
    return _logger.i(message, error: error, stackTrace: stackTrace);
  }

  void printLog(Object? message) {
    DebugLogger.log.logD(message);
  }

  void printError(Object? message) {
    DebugLogger.log.logE(message);
  }

  void printInfo(Object? message) {
    DebugLogger.log.logI(message);
  }
}