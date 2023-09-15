part of result;

/// App Context Error
class AppError extends Error {
  final String? message;
  final AppException? appException;

  /// The exception that caused the error.
  ///
  /// usually not [null] when [appException] is [AppException.external]
  final Exception? exception;
  final String? description;
  late final StackTrace _st;

  @override
  StackTrace get stackTrace => _st;

  AppError({
    this.message,
    this.appException,
    this.description,
    this.exception,
    StackTrace? st,
  })  : assert(message != null ||
            appException != null ||
            description != null ||
            exception != null),
        _st = st ?? StackTrace.current;

  @override
  String toString() {
    return ''' <$runtimeType>
                 message:     $message 
                 appException:   ${appException?.name} 
                 exception:     $exception
                 description: $description
                 Stacktrace: $stackTrace ''';
  }

  AppError copyWith({
    String? message,
    AppException? appException,
    Exception? exception,
    String? description,
    StackTrace? stackTrace,
  }) {
    return AppError(
      message: message ?? this.message,
      appException: appException ?? this.appException,
      exception: exception ?? this.exception,
      description: description ?? this.description,
      st: stackTrace ?? this.stackTrace,
    );
  }
}

/// Used to represents the type of error in a [SuccessResult]
abstract class NoError extends AppError {}
