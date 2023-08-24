import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'isar_testing_utils.dart';

@isTest
Future<void> testWithDatasets<T>(
  String description, {
  required List<T> datasets,
  required FutureOr<void> Function(T data) testBody,
}) async {
  test(description, () async {
    for (var dataset in datasets) {
      await testBody(dataset);
      await IsarTestingUtils.refreshDatabase();
    }
  });
}
