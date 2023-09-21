import 'dart:io';

import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/support/extensions/extensions.dart';

final class MusicFolderHelper {
  static MusicFolder? createInstance(
    String? path,
    Set<MusicFolder> currentFolders,
  ) {
    if (path == null || _musicFolderAlreadyExists(path, currentFolders)) {
      return null;
    }
    final subFolders = Directory(path)
        .listSync(recursive: true)
        .whereType<Directory>()
        .toList()
        .map((e) => e.absolute.path)
        .toSet();
    return MusicFolder(path: path, subFolders: subFolders);
  }

  static bool _musicFolderAlreadyExists(
      String path, Set<MusicFolder> currentFolders) {
    final existsAsParentMF =
        currentFolders.containsWhere((e) => e.path == path);
    if (!existsAsParentMF) {
      return currentFolders.containsWhere((e) => e.subFolders.contains(path));
    }
    return existsAsParentMF;
  }
}
