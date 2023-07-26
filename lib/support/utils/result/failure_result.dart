part of result;

/// Used as a return type for an unsuccessful execution of a function.
///
/// [AppError] `error` should specifies the failure reason.

class FailureResult<V extends Object?, ErrorType extends AppError>
    extends Result<V, ErrorType> {
  final ErrorType error;
  final V? previousValue;

  FailureResult(this.error, {this.previousValue}) : super._();

  factory FailureResult.withPreviousValue(ErrorType error, V value) {
    return FailureResult(error, previousValue: value);
  }

  factory FailureResult.withException(Exception e) {
    return FailureResult(AppError(
      message: e.toString(),
      appException: AppException.external,
      exception: e,
    ) as ErrorType);
  }

  factory FailureResult.withMessage(String message) {
    return FailureResult(
      AppError(message: message) as ErrorType,
    );
  }

  factory FailureResult.withAppException(AppException appException) {
    return FailureResult(AppError(appException: appException) as ErrorType);
  }

  @override
  String toString() {
    return 'FailureResult: $error';
  }

  @override
  Future<Result<U, F>> mapSuccessAsync<U extends Object?, F extends AppError>(
      Future<U> Function(V value) transform) async {
    return FailureResult(error as F);
  }

  @override
  Result<U, F> mapSuccess<U extends Object?, F extends AppError>(
      U Function(V value) transform) {
    return FailureResult(error as F);
  }

  @override
  Result<U, F> mapFailure<U extends Object, F extends AppError>(
      F Function(ErrorType error) transform) {
    return FailureResult(transform(error));
  }

  @override
  Future<Result<U, F>> mapFailureAsync<U extends Object, F extends AppError>(
      Future<F> Function(ErrorType error) transform) async {
    return FailureResult(await transform(error));
  }

  @override
  Result<U, F> flatMapSuccess<U extends Object?, F extends AppError>(
      Result<U, F> Function(V value) transform) {
    return FailureResult(error as F);
  }

  @override
  Future<Result<U, F>>
      flatMapSuccessAsync<U extends Object?, F extends AppError>(
    Future<Result<U, F>> Function(V value) transform,
  ) async {
    return FailureResult(error as F);
  }

  @override
  Result<U, F> flatMapFailure<U extends Object, F extends AppError>(
    Result<U, F> Function(ErrorType error) transform,
  ) {
    return transform(error);
  }

  @override
  Future<Result<U, F>>
      flatMapFailureAsync<U extends Object, F extends AppError>(
    Future<Result<U, F>> Function(ErrorType error) transform,
  ) async {
    return await transform(error);
  }

  @override
  Result<VoidValue, ErrorType> mapSuccessToVoid({
    void Function(V value)? onSuccess,
  }) {
    return FailureResult(error);
  }

  @override
  Future<Result<VoidValue, ErrorType>> mapSuccessToVoidAsync({
    Future<void> Function(V value)? onSuccess,
  }) async {
    return FailureResult(error);
  }

  @override
  Result<T, F> flatMap<T extends Object, F extends AppError>({
    required Result<T, F> Function(V value) onSuccess,
    required Result<T, F> Function(ErrorType error) onFailure,
  }) {
    return onFailure(error);
  }

  @override
  Future<Result<T, F>> flatMapAsync<T extends Object, F extends AppError>({
    required Future<Result<T, F>> Function(V value) onSuccess,
    required Future<Result<T, F>> Function(ErrorType error) onFailure,
  }) async {
    return await onFailure(error);
  }

  @override
  Result<T, F> map<T extends Object, F extends AppError>({
    required T Function(V value) onSuccess,
    required F Function(ErrorType error) onFailure,
  }) {
    return FailureResult(onFailure(error));
  }

  @override
  Future<Result<T, F>> mapAsync<T extends Object, F extends AppError>({
    required Future<T> Function(V value) onSuccess,
    required Future<F> Function(ErrorType error) onFailure,
  }) async {
    return FailureResult(await onFailure(error));
  }

  @override
  Result<V, ErrorType> fold({
    void Function(V value)? onSuccess,
    void Function(ErrorType error)? onFailure,
  }) {
    if (onFailure != null) {
      onFailure(error);
    }
    return FailureResult(error);
  }

  @override
  Future<Result<V, ErrorType>> foldAsync({
    Future<void> Function(V value)? onSuccess,
    Future<void> Function(ErrorType error)? onFailure,
  }) async {
    if (onFailure != null) {
      await onFailure(error);
    }
    return FailureResult(error);
  }

  @override
  T mapTo<T>({
    T Function(V value)? onSuccess,
    T Function(ErrorType error)? onFailure,
  }) {
    return onFailure != null ? onFailure(error) : null as T;
  }

  @override
  Future<T> mapToAsync<T>({
    Future<T> Function(V value)? onSuccess,
    Future<T> Function(ErrorType error)? onFailure,
  }) async {
    return onFailure != null ? await onFailure(error) : null as T;
  }

  @override
  U mapFailureTo<U>(U Function(ErrorType error) transform) {
    return transform(error);
  }

  @override
  U mapSuccessTo<U>(U Function(V value) transform) {
    return FailureResult(error) as U;
  }
}

extension FailureResultExtension<V extends Object> on AppError {
  FailureResult<V, AppError> get asResult => FailureResult(this);
}
