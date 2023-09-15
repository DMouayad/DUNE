part of result;

class ExceptionHandler {
  static Result<U, V> getResult<U, V extends AppError>(
      dynamic e, StackTrace stack) {
    V? error;
    if (e is V) {
      error = e;
    } else if (e is IsarError) {
      error = AppError(message: e.message, st: e.stackTrace) as V;
    } else if (e is ClientException) {
      error = AppError(
        message: e.message,
        appException: AppException.cannotConnectToServer,
      ) as V;
    } else if (e is Error) {
      error = AppError(
        st: e.stackTrace,
        description: e.toString(),
      ) as V;
    }
    if (error != null) {
      error = error.copyWith(stackTrace: stack) as V;
    }
    Log.e(error);
    return error != null
        ? FailureResult(error)
        : FailureResult.withException(e);
  }
}
