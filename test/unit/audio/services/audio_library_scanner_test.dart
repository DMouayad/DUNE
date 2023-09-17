import 'dart:io';

import 'package:dune/data/audio/local/services/taggy_track_from_file_extractor.dart';
import 'package:dune/domain/audio/services/audio_library_scanner.dart';
import 'package:flutter_taggy/flutter_taggy.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/constants.dart';

void main() {
  late final AudioLibraryScanner scanner;
  final imagesDir = Directory('${Directory.current.path}\\test\\images');

  setUpAll(() async {
    Taggy.initialize();
    // create the temporary folder to hold any extracted images

    scanner = AudioLibraryScanner(
      trackExtractor: TaggyTrackFromFileExtractor(),
      directoryToSaveExtractedImages: imagesDir.absolute.path,
    );
  });
  setUp(() async => await imagesDir.create());
  // remove the images directory with its files
  tearDown(() async => await imagesDir.delete(recursive: true));

  group('scanning a directory tests', () {
    test('it returns failure for a non-existing directory', () async {
      final result = await scanner.scanDirectory('fake/directory');
      expectLater(result.isFailure, true);
    });
    test('it reads all files in a directory', () async {
      final tracks = await scanner.scanDirectory(kPathToAnAlbumFolder);
      expectLater(tracks.isSuccess, true);
      expectLater(
        tracks.requireValue.length,
        scanner.getDirectoryAudioFilesNumber(kPathToAnAlbumFolder),
      );
    });
    test('it saves extracted images to the specified folder', () async {
      // assert the directory is empty before saving any images
      expect(imagesDir.listSync().isEmpty, true);
      final result =
          await scanner.scanDirectory(kPathToFolderOfTracksWithDifferentCovers);
      final uniqueFileNames =
          result.requireValue.map((e) => e.album?.title ?? e.title).toSet();
      // assert it saved each track cover image
      expectLater(imagesDir.listSync().length, uniqueFileNames.length);
    });
  });
}
