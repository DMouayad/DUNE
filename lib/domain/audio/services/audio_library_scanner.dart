import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'base_file_track_extractor.dart';

/// Responsible for scanning a given folder(directory) for audio tracks.
///
class AudioLibraryScanner {
  const AudioLibraryScanner(this._trackExtractor);

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
      return (await (_getAudioFiles(dir))
              .asyncMap((file) async => await _getTrackFromFile(file))
              .takeWhile((track) => track != null)
              .toList())
          .cast<BaseTrack>()
          .asResult;
    } else {
      return FailureResult.withAppException(AppException.directoryNotFound);
    }
  }

  /// Scans the provided [Directory] recursively for audio files only.
  /// Returns the files in a [Stream]
  Stream<File> _getAudioFiles(Directory dir) {
    return dir.list(recursive: true).takeWhile((fileEntity) {
      return fileEntity is File && _isAudioFile(fileEntity);
    }).cast();
    // (fileEntity) async {
    //   } else if (fileEntity is Directory) {
    //     await _getAudioFilesPaths(fileEntity)
    //         .foldThen(onSuccess: (subDirFiles) => paths.addAll(subDirFiles));
    //   }
    // });
  }

  /// Returns whether the provided [file] is an audio file based on its type
  bool _isAudioFile(File file) {
    return _audioFilesExtensions.contains(p.extension(file.path.toLowerCase()));
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
      return (await _savePictureToFile(extractedThumbnail.data, track.title))
          .mapTo(
        onSuccess: (imagePath) {
          final thumb = extractedThumbnail.thumb.copyWith(url: imagePath);
          return track.copyWith(thumbnails: ThumbnailsSet(thumbnails: [thumb]));
        },
        onFailure: (_) => track,
      );
    }
  }

  FutureResult<String> _savePictureToFile(
    List<int> pictureData,
    String trackTitle,
  ) async {
    return await Isolate.run(() async {
      return await Result.fromAsync(() async {
        final appDir = await getApplicationDocumentsDirectory();
        final imageFilePath = p.absolute(appDir.path, '$trackTitle.png}');
        final imageFile = File(imageFilePath);
        // [writeAsBytes] will automatically closes the writer sink when done
        await imageFile.writeAsBytes(pictureData);
        return imageFilePath;
      });
    });
  }
}

const _audioFilesExtensions = ['.mp3', '.mp4', '.m4a', '.wav', '.aac', 'flac'];
