import 'dart:io';
import 'package:flutter_taggy/flutter_taggy.dart';
import 'package:flutter_test/flutter_test.dart';

//
import 'package:dune/data/audio/local/services/taggy_track_from_file_extractor.dart';
import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/services/base_file_track_extractor.dart';

import '../../../utils/constants.dart';

void main() {
  late final TaggyTrackFromFileExtractor extractor;
  final validTestAudioFile = File(kPathToAudioFile);

  setUpAll(() {
    Taggy.initialize();
    extractor = TaggyTrackFromFileExtractor();
  });

  group('creating a new instance', () {
    test('it returns [null] if the file does not exist', () async {
      final nonExistingFile = File('/not/a/path/audio.mp3');
      final extractorInstance = await extractor.newExtractor(nonExistingFile);
      expect(extractorInstance, null);
    });
    test('it returns [null] if the file is not an audio file', () async {
      final nonExistingFile = File('/not/a/path/file.txt');
      final extractorInstance = await extractor.newExtractor(nonExistingFile);
      expect(extractorInstance, null);
    });
    test('it returns a new instance successfully for an existing file',
        () async {
      final extractorInstance =
          await extractor.newExtractor(validTestAudioFile);
      expect(extractorInstance.runtimeType, TaggyTrackFromFileExtractor);
    });
  });
  group(
    'extracting track from a valid audio file',
    () {
      late final BaseTrackFromFileExtractor fileExtractor;
      setUpAll(() async {
        fileExtractor = (await extractor.newExtractor(validTestAudioFile))!;
      });
      test('it extracts a [BaseTrack]', () {
        expect(fileExtractor.extractTrack().runtimeType, BaseTrack);
      });
      test('it extracts a [BaseAlbum]', () {
        expect(fileExtractor.extractAlbum().runtimeType, BaseAlbum);
      });
      test('it extracts track-artists list and album-artists list', () {
        expect(fileExtractor.extractArtists().runtimeType, ArtistsFromFile);
        expect(fileExtractor.extractArtists().albumArtists, <BaseArtist>[]);
        expect(fileExtractor.extractArtists().trackArtists.isNotEmpty, true);
      });
      test('it extracts an [AudioInfoSet]', () {
        expect(fileExtractor.extractAudioInfoSet().runtimeType, AudioInfoSet);
        final audioInfo = fileExtractor.extractAudioInfoSet()!.items.single;
        // it should has the same path of the file we used
        expect(audioInfo.url, fileExtractor.file.path);
        expect(audioInfo.channelMask != null, true);
        expect(audioInfo.channels != null, true);
        expect(audioInfo.bitsPerSecond != null, true);
        expect(audioInfo.samplingRate != null, true);
        expect(audioInfo.format != null, true);
        expect(audioInfo.totalBytes != null, true);
      });
      test('it extracts thumbnails', () {
        // we know the file has a cover image
        expect(fileExtractor.extractThumbnails().isNotEmpty, true);
      });
      test('it assigns width, height and data of a [BaseThumbnail]', () {
        final extractedThumbInfo =
            fileExtractor.extractThumbnails().firstOrNull;
        expect(extractedThumbInfo != null, true);
        expect(extractedThumbInfo!.thumb.height != null, true);
        expect(extractedThumbInfo.thumb.width != null, true);
      });
    },
  );
}
