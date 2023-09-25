import 'dart:io';
import 'package:path/path.dart' as p;

const _audioFilesExtensions = ['.mp3', '.mp4', '.m4a', '.wav', '.aac', '.flac'];

mixin AudioFilesScanner {
  /// Scans the provided [Directory] recursively for audio files only.
  /// Returns the files in a [Stream]
  Stream<File> getAudioFiles(Directory dir) {
    return dir.list(recursive: true).where((fileEntity) {
      return fileEntity is File && _isAudioFile(fileEntity);
    }).cast();
  }

  /// Returns whether the provided [file] is an audio file based on its type
  bool _isAudioFile(File file) {
    final extension = p.extension(file.path.toLowerCase());
    return _audioFilesExtensions.contains(extension);
  }

  int getDirectoryAudioFilesCount(String path) {
    return Directory(path)
        .listSync(recursive: true)
        .where((e) => e is File && _isAudioFile(e))
        .length;
  }
}
