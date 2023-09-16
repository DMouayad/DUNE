import 'dart:io';

/// Provides a convenient way to cleanup a temporarily path(file\directory)
/// after it's been used in some [operation] and regarding of its outcome.
Future<void> withTempPath(
  String path,
  Future<void> Function() operation,
) async {
  try {
    await operation();
  } catch (e) {
    // clean up the duplicated file then re-throw the exception
    File(path).deleteSync(recursive: true);
    rethrow;
  }
  // clean up the duplicated file also when no error occurs.
  File(path).deleteSync(recursive: true);
}
