import 'dart:async';
import 'dart:io';
import 'package:dune/support/logger_service.dart';
import 'package:path/path.dart' as p;

//
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/utils/result/result.dart';

import 'audio_files_scanner.dart';
import 'base_file_track_extractor.dart';
import 'image_files_scanner.dart';

/// Responsible for scanning a given folder(directory) for audio tracks.
class AudioLibraryScanner with AudioFilesScanner, ImagesScanner {
  AudioLibraryScanner({
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
    clearCachedImagePaths();
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
    if (track == null) return track;
    return await _assignThumbnailsToTrack(track, extractor.extractThumbnails());
  }

  Future<BaseTrack> _assignThumbnailsToTrack(
    BaseTrack track,
    List<ThumbnailInfo> extractedThumbnails,
  ) async {
    final ThumbnailInfo? thumbData =
        extractedThumbnails.firstOrNull ?? await scanDirForImages(track);
    if (thumbData == null) {
      return track;
    } else {
      return (await _savePictureToFile(
        thumbData.data,
        // it's better to use the album name to minimize the chance of
        // saving an image multiple times.
        track.album?.title ?? track.title,
      ))
          .mapTo(
        onSuccess: (imagePath) {
          final thumb = thumbData.thumb.copyWith(url: imagePath);
          final thumbnailsSet = ThumbnailsSet(thumbnails: [thumb]);
          final albumWithThumb =
              track.album?.copyWith(thumbnails: thumbnailsSet);
          return track.copyWith(
              thumbnails: thumbnailsSet, album: albumWithThumb);
        },
        onFailure: (e) {
          Log.e(
            "Failed to save image. for track: ${track.title}\n"
            "Thumb:${thumbData.thumb}",
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
        // if it already exists, do nothing
      } else {
        await imageFile.writeAsBytes(pictureData);
      }
      return imageFilePath;
    });
  }
}
