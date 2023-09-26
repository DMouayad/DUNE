import 'dart:io';
import 'package:dune/support/extensions/extensions.dart';
import 'package:path/path.dart' as p;

import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';

import 'base_file_track_extractor.dart';

typedef DirectoryPath = String;
typedef ImagePath = String;

mixin ImagesScanner {
  final Map<DirectoryPath, Set<ImagePath>> _foundImages = {};

  void clearCachedImagePaths() => _foundImages.clear();

  /// Search in the track directory for what could be an cover image for it.
  Future<ThumbnailInfo?> scanDirForImages(BaseTrack track) async {
    final trackPath = track.audioInfoSet?.items.firstOrNull?.url;

    if (trackPath == null || !File(trackPath).parent.existsSync()) {
      return null;
    }

    final dir = File(trackPath).parent;

    /// The path to image which matches the track title\album title
    final String? imagePath;
    if (_foundImages.containsKey(dir.path)) {
      imagePath = _foundImages
          .whereKey(dir.path)
          ?.firstWhereOrNull((p) => _pathHasTrackOrAlbumName(track, p));
    } else {
      final imagesInDir = await dir
          .list(recursive: true)
          .where((fileEntity) =>
              fileEntity is File &&
              _isImageFile(fileEntity) &&
              _pathHasTrackOrAlbumName(track, fileEntity.path))
          .toList();
      imagePath = imagesInDir.cast<File>().firstOrNull?.path;
      _addImagePathToFoundMap(imagePath, dir);
    }
    if (imagePath != null) {
      return _getThumbInfoFromFile(imagePath);
    }

    return null;
  }

  void _addImagePathToFoundMap(String? path, Directory dir) {
    if (path != null) {
      _foundImages.update(
        dir.path,
        (value) => {...value, path},
        ifAbsent: () => {path},
      );
    }
  }

  ThumbnailInfo _getThumbInfoFromFile(String path) {
    final file = File(path);
    final data = file.readAsBytesSync();
    final thumb = BaseThumbnail(
      url: file.absolute.path,
      quality: ThumbnailQuality.standard,
      isNetwork: false,
    );
    return (data: data, thumb: thumb);
  }

  bool _pathHasTrackOrAlbumName(BaseTrack track, String path) {
    return path
        .toLowerCase()
        .contains((track.album?.title ?? track.title).toLowerCase());
  }

  /// Returns whether the provided [file] is an image file based on its type
  bool _isImageFile(File file) {
    final extension = p.extension(file.path.toLowerCase());
    return _imageFilesExtensions.contains(extension);
  }
}

const _imageFilesExtensions = ['.jpg', '.jpeg', '.png'];
