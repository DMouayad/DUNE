part of result;

extension AsyncResultExtension<V, E extends AppError>
    on FutureOr<Result<V, E>> {
  Future<void> foldThen<R>({
    FutureOr<R> Function(V value)? onSuccess,
    Function(E)? onFailure,
  }) async {
    (await this).foldAsync(
      onSuccess: (value) async => onSuccess != null ? onSuccess(value) : null,
      onFailure: (error) async => onFailure != null ? onFailure(error) : null,
    );
  }

  Future<bool> get isSuccessAndNotNull async => (await this).mapTo(
        onSuccess: (value) => value != null,
        onFailure: (_) => false,
      );
}

extension SuccessResultExtension<V extends Object?> on V {
  SuccessResult<V, NoError> get asResult => SuccessResult(this);
}
