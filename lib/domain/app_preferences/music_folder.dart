part of 'base_app_preferences.dart';

/// Represents a local folder where we'd search for audio files.
class MusicFolder extends Equatable {
  /// The path to this folder on user's device.
  final String path;

  /// All discovered sub-folders of this folder.
  ///
  /// When the user selects a directory, we, recursively, get it's sub-directories
  /// and put them in this field.
  final Set<String> subFolders;

  /// The date this folder was added by the user.
  final DateTime addedOn;

  MusicFolder({
    required this.path,
    this.subFolders = const {},
  }) : addedOn = DateTime.now();

  @override
  List<Object?> get props => [path, subFolders, addedOn];
}
