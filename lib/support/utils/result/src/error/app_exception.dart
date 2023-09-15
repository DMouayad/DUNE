part of result;

/// Custom app exception
///
/// Used to determine the error message.
enum AppException {
  noConnectionFound,
  cannotConnectToServer,
  emailAlreadyRegistered,
  invalidEmailCredential,
  invalidPasswordCredential,
  decodingJsonFailed,
  weekCredentialPassword,
  modelNotFound,
  failedLoadingBooks,
  usernameNotRegistered,
  actionNotSupported,
  directoryNotFound,

  /// indicates that an undefined exception was thrown/returned.
  ///
  /// applies for platform exceptions, unregistered api exceptions,
  /// plugins exception, server exceptions, etc
  external;

  String get message => name;
}
