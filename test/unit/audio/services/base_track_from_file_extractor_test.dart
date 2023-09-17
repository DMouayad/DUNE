import 'dart:async';

import 'dart:io';

import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_thumbnail.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/factories/album_factory.dart';
import 'package:dune/domain/audio/factories/artist_factory.dart';
import 'package:dune/domain/audio/factories/track_factory.dart';
import 'package:dune/domain/audio/services/base_file_track_extractor.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/constants.dart';
import '../../../utils/equality_helper.dart';

const kArtistsCount = 2;

/// The artists we expect to be extracted.
final artists =
    ArtistFactory().setMusicSource(MusicSource.local).createCount(2);

/// The album we expect to be extracted.
final album = AlbumFactory().setMusicSource(MusicSource.local).create();
final trackToBeExtracted = TrackFactory()
    .withAudioInfo(itemsCount: 1)
    .setMusicSource(MusicSource.local)
    .withAlbum(album)
    .withArtists(artists: artists)
    .create();

final class FakeTrackFromFileExtractor extends BaseTrackFromFileExtractor {
  FakeTrackFromFileExtractor({super.file, BaseTrack? track}) : _track = track;
  late final BaseTrack? _track;

  @override
  BaseAlbum? extractAlbum() => _track!.album;

  @override
  AudioInfoSet? extractAudioInfoSet() => _track!.audioInfoSet;

  @override
  List<({List<int> data, BaseThumbnail thumb})> extractThumbnails() {
    return _track!.thumbnails.thumbnails
        .map((e) => (data: <int>[], thumb: e))
        .toList();
  }

  @override
  BaseTrack<BaseAlbum, BaseArtist>? extractTrack() {
    return _track;
  }

  @override
  FutureOr<BaseTrackFromFileExtractor?> newExtractor(File file) {
    return FakeTrackFromFileExtractor(track: trackToBeExtracted, file: file);
  }

  @override
  String? get getAlbumArtistString => _track!.artistsNames;

  @override
  String? get getTrackArtistString => _track!.artistsNames;
}

void main() {
  final validTestAudioFile = File(kPathToAudioFile);
  group('[getTrackWithPropsAttached()] tests', () {
    late final BaseTrack track;

    setUpAll(() async {
      final extractorInstance =
          await FakeTrackFromFileExtractor().newExtractor(validTestAudioFile);
      track = extractorInstance!.getTrackWithPropsAttached()!;
    });
    test('The track album is attached', () async {
      final isEqual = EqualityHelper.albumsHasSameProps(track.album, album);
      expect(isEqual, isTrue);
    });

    test('The track artists is attached', () {
      expect(track.artists.length, artists.length);
    });

    test('The track [AudioInfoSet] is attached', () {
      expect(track.audioInfoSet, trackToBeExtracted.audioInfoSet);
    });

    test("The track album has artists and track attached", () {
      expect(track.album?.tracks, hasLength(1));
      expect(track.album?.artists.length, artists.length);
    });

    test("The track artist have album and track attached", () {
      final wasAttached = track.artists.every(
          (artist) => artist.tracks.length == 1 && artist.albums.length == 1);
      expect(wasAttached, isTrue);
    });
  });
}
