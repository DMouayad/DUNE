part of result;

class SuccessResult<V extends Object?, E extends NoError> extends Result<V, E> {
  final V value;

  const SuccessResult(this.value) : super._();

  /// Indicates a successful execution of a function which has return type of `void`.
  static SuccessResult<VoidValue, N> voidResult<N extends NoError>() =>
      const SuccessResult(VoidValue());

  factory SuccessResult.withJson(String json) {
    return SuccessResult(JsonObjectResult(jsonDecode(json)) as V);
  }

  @override
  Future<Result<U, F>> mapSuccessAsync<U extends Object?, F extends AppError>(
    Future<U> Function(V value) transform,
  ) async {
    return SuccessResult(await transform(value));
  }

  @override
  Result<U, F> mapSuccess<U extends Object?, F extends AppError>(
      U Function(V value) transform) {
    return SuccessResult(transform(value));
  }

  @override
  Result<U, F> mapFailure<U extends Object, F extends AppError>(
      F Function(E error) transform) {
    return SuccessResult(value as U);
  }

  @override
  Future<Result<U, F>> mapFailureAsync<U extends Object, F extends AppError>(
      Future<F> Function(E error) transform) async {
    return SuccessResult(value as U);
  }

  @override
  Result<U, F> flatMapSuccess<U extends Object?, F extends AppError>(
      Result<U, F> Function(V value) transform) {
    return transform(value);
  }

  @override
  Future<Result<U, F>>
      flatMapSuccessAsync<U extends Object?, F extends AppError>(
    Future<Result<U, F>> Function(V value) transform,
  ) async {
    return await transform(value);
  }

  @override
  Result<U, F> flatMapFailure<U extends Object, F extends AppError>(
      Result<U, F> Function(E error) transform) {
    return SuccessResult(value as U);
  }

  @override
  Future<Result<U, F>>
      flatMapFailureAsync<U extends Object, F extends AppError>(
          Future<Result<U, F>> Function(E error) transform) async {
    return SuccessResult(value as U);
  }

  @override
  Result<VoidValue, E> mapSuccessToVoid({void Function(V value)? onSuccess}) {
    if (onSuccess != null) {
      onSuccess(value);
    }
    return SuccessResult.voidResult();
  }

  @override
  Future<Result<VoidValue, E>> mapSuccessToVoidAsync(
      {Future<void> Function(V value)? onSuccess}) async {
    if (onSuccess != null) {
      await onSuccess(value);
    }
    return SuccessResult.voidResult();
  }

  @override
  Result<U, F> flatMap<U extends Object, F extends AppError>({
    required Result<U, F> Function(V value) onSuccess,
    required Result<U, F> Function(E error) onFailure,
  }) {
    return onSuccess(value);
  }

  @override
  Future<Result<U, F>> flatMapAsync<U extends Object, F extends AppError>({
    required Future<Result<U, F>> Function(V value) onSuccess,
    required Future<Result<U, F>> Function(E error) onFailure,
  }) async {
    return await onSuccess(value);
  }

  @override
  Result<U, F> map<U extends Object, F extends AppError>({
    required U Function(V value) onSuccess,
    required F Function(E error) onFailure,
  }) {
    return SuccessResult(onSuccess(value));
  }

  @override
  Future<Result<U, F>> mapAsync<U extends Object, F extends AppError>({
    required Future<U> Function(V value) onSuccess,
    required Future<F> Function(E error) onFailure,
  }) async {
    return SuccessResult(await onSuccess(value));
  }

  @override
  Future<Result<V, E>> foldAsync({
    Future<void> Function(V value)? ifSuccess,
    Future<void> Function(E error)? ifFailure,
  }) async {
    if (ifSuccess != null) {
      await ifSuccess(value);
    }
    return SuccessResult(value);
  }

  @override
  U mapTo<U>({
    U Function(V value)? onSuccess,
    U Function(E error)? onFailure,
  }) {
    return onSuccess != null ? onSuccess(value) : value as U;
  }

  @override
  Future<U> mapToAsync<U>({
    Future<U> Function(V value)? onSuccess,
    Future<U> Function(E error)? onFailure,
  }) async {
    return onSuccess != null ? await onSuccess(value) : null as U;
  }

  @override
  Result<V, E> fold({
    void Function(V value)? ifSuccess,
    void Function(E error)? ifFailure,
  }) {
    if (ifSuccess != null) {
      ifSuccess(value);
    }
    return SuccessResult(value);
  }

  @override
  U mapFailureTo<U>(U Function(E error) transform) {
    return SuccessResult(value) as U;
  }

  @override
  U mapSuccessTo<U>(U Function(V value) transform) {
    return transform(value);
  }
}
