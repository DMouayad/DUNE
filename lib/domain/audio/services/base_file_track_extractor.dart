import 'dart:async';
import 'dart:io';

import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/file_extension.dart';

typedef ArtistsFromFile = ({
  List<BaseArtist> trackArtists,
  List<BaseArtist> albumArtists
});

/// Extracts a [BaseTrack] from a given [File].
///
/// **Note:** when extracting from a file, [newExtractor()] should always be used
/// to create an instance for this specific file.
abstract class BaseTrackFromFileExtractor {
  BaseTrackFromFileExtractor({this.file});

  /// Returns a new extractor instance for the given file.
  FutureOr<BaseTrackFromFileExtractor?> newExtractor(File file);

  /// The file to extract the track data from.
  final File? file;

  /// Combines the extracted info from the file into a one [BaseTrack] instance.
  ///
  /// It's different from the [extractTrack] method since the later only return
  /// the acquired track without setting its [BaseAlbum], [BaseArtist],
  /// or [AudioInfoSet].
  BaseTrack? getTrackWithPropsAttached() {
    if (file == null) {
      throw StateError("file has not been specified!\n"
          'Hint: always use [newExtractor()] and pass it a [File] instance');
    }
    var track = extractTrack();
    if (track == null) return null;

    if (track.title.isEmpty) {
      track = track.copyWith(title: file!.extractName);
    }
    track = track.assignIdIfEmpty();

    final artists = extractArtists();
    final album = extractAlbum()?.copyWith(tracks: [track]);

    /// The extracted album artists
    final albumArtists = _attachToArtists(artists.albumArtists, track, album);
    final albumWithArtists = album?.copyWith(artists: albumArtists);

    final trackArtists = _attachToArtists(artists.trackArtists, track, album);

    return track.copyWith(
      album: albumWithArtists,
      artists: {...trackArtists, ...albumArtists}.toList(),
      audioInfoSet: extractAudioInfoSet(),
    );
  }

  List<BaseArtist> _attachToArtists(
    List<BaseArtist> artists,
    BaseTrack track,
    BaseAlbum? album,
  ) {
    return artists
        .map((e) =>
            e.copyWith(tracks: [track], albums: album != null ? [album] : []))
        .toList();
  }

  BaseAlbum? extractAlbum();

  BaseTrack? extractTrack();

  AudioInfoSet? extractAudioInfoSet();

  List<({BaseThumbnail thumb, List<int> data})> extractThumbnails();

  String? get getTrackArtistString;

  String? get getAlbumArtistString;

  ArtistsFromFile extractArtists() {
    return (
      trackArtists: _getArtistsFromString(getTrackArtistString),
      albumArtists: _getArtistsFromString(getAlbumArtistString),
    );
  }

  List<BaseArtist> _getArtistsFromString(String? str) {
    return str
            ?.split(', ')
            .where((name) => name.isNotEmpty)
            .map(_artistFromName)
            .toList() ??
        [];
  }

  BaseArtist _artistFromName(String name) {
    return BaseArtist(
      id: null,
      browseId: null,
      radioId: null,
      shuffleId: null,
      category: null,
      name: name,
      description: '',
      thumbnails: const ThumbnailsSet(),
      tracks: const [],
      albums: const [],
      musicSource: MusicSource.local,
    ).setIdIfNull();
  }
}
