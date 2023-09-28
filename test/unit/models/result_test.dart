import 'package:dune/support/utils/result/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[fromAnother] function tests', () {
    test('it transforms another [FailureResult] to required type', () async {
      final Result<VoidValue, AppError> result =
          await Result.fromAnother(() async {
        return FailureResult<String, AppError>(AppError(message: 'fake error'));
      });
      expect(result.isFailure, true);
    });
    test(
        'it transforms another [SuccessResult] with same value type to required'
        ' [Result] type', () async {
      final Result<VoidValue, AppError> result =
          await Result.fromAnother(() async => SuccessResult.voidResult());
      expect(result.isSuccess, true);
    });
    test(
        'it returns a [FailureResult] when'
        '[fromAnother] receives a [SuccessResult] with mismatched value type',
        () async {
      final Result<VoidValue, AppError> result = await Result.fromAnother(
          () async => const SuccessResult<String, NoError>("value"));
      expect(result.isFailure, true);
    });
  });
}
