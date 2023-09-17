import 'dart:async';
import 'dart:io';
import 'package:dune/support/logger_service.dart';
import 'package:path/path.dart' as p;

//
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/utils/result/result.dart';

import 'base_file_track_extractor.dart';

/// Responsible for scanning a given folder(directory) for audio tracks.
class AudioLibraryScanner with AudioFilesScanner {
  const AudioLibraryScanner({
    required BaseTrackFromFileExtractor trackExtractor,
    required this.directoryToSaveExtractedImages,
  }) : _trackExtractor = trackExtractor;

  /// The path to the directory in which all extracted images from audio files
  /// will be saved.
  final String directoryToSaveExtractedImages;

  final BaseTrackFromFileExtractor _trackExtractor;

  /// Returns a list of tracks found in the directory at given [path]
  ///
  /// If directory doesn't exists, a `FailureResult` is returned with
  /// `AppException.directoryNotFound`
  FutureOrResult<List<BaseTrack>> scanDirectory(String path) async {
    final dir = Directory(path);

    if (dir.existsSync()) {
      // first get all of the audio files in the [dir] and its sub-directories
      // then extract a track from each file, if possible.
      return (await (getAudioFiles(dir))
              .asyncMap((file) async => await _getTrackFromFile(file))
              .takeWhile((track) => track != null)
              .toList())
          .cast<BaseTrack>()
          .asResult;
    } else {
      return FailureResult.withAppException(AppException.directoryNotFound);
    }
  }

  Future<BaseTrack?> _getTrackFromFile(File file) async {
    final extractor = await _trackExtractor.newExtractor(file);
    if (extractor == null) return null;

    final track = extractor.getTrackWithPropsAttached();
    final coverThumbnails = extractor.extractThumbnails();

    // for now, we'll be saving only one image
    final extractedThumbnail = coverThumbnails.firstOrNull;

    if (track == null || extractedThumbnail == null) {
      return track;
    } else {
      return (await _savePictureToFile(
        extractedThumbnail.data,
        // it's better to use the album name to minimize the chance of
        // saving an image multiple times.
        track.album?.title ?? track.title,
      ))
          .mapTo(
        onSuccess: (imagePath) {
          final thumb = extractedThumbnail.thumb.copyWith(url: imagePath);
          return track.copyWith(thumbnails: ThumbnailsSet(thumbnails: [thumb]));
        },
        onFailure: (e) {
          Log.e(
            "Failed to save image. for track: ${track.title}\n"
            "Thumb:${extractedThumbnail.thumb}",
          );
          return track;
        },
      );
    }
  }

  FutureResult<String> _savePictureToFile(
    List<int> pictureData,
    String imageTitle,
  ) async {
    return await Result.fromAsync(() async {
      final titleFiltered = imageTitle.replaceAll(RegExp(r'[/?*<>:|"]'), '_');
      final imageFilePath =
          p.absolute(directoryToSaveExtractedImages, '$titleFiltered.png');
      // [writeAsBytes] will automatically closes the writer sink when done
      final imageFile = File(imageFilePath);
      if (imageFile.existsSync()) {
        // if it already exists, don't save again
      } else {
        await imageFile.writeAsBytes(pictureData);
      }
      return imageFilePath;
    });
  }
}

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

  int getDirectoryAudioFilesNumber(String path) {
    return Directory(path)
        .listSync(recursive: true)
        .where((e) => e is File && _isAudioFile(e))
        .length;
  }
}
