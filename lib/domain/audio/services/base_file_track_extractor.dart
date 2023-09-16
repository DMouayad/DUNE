import 'dart:async';
import 'dart:io';

import 'package:dune/domain/audio/base_models/audio_info_set.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
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
  BaseTrackFromFileExtractor();

  /// Returns a new extractor instance.
  /// This exists in case the process of creating this instance may take some
  /// time i.e. it's an async op
  FutureOr<BaseTrackFromFileExtractor?> newExtractor(File file);

  /// The file to extract the track data from.
  File get file;

  /// Combines the extracted info from the file into a one [BaseTrack] instance.
  ///
  /// It's different from the [extractTrack] method since the later only return
  /// the acquired track without setting its [BaseAlbum], [BaseArtist],
  /// or [AudioInfoSet].
  BaseTrack? extractTrackAndAttachProps() {
    var track = extractTrack();
    if (track == null) return null;

    if (track.title.isEmpty) {
      track = track.copyWith(title: file.extractName);
    }
    track = track.assignIdIfEmpty();

    final artists = extractArtists();
    final album = extractAlbum()?.copyWith(tracks: [track]);

    /// The extracted album artists
    final albumArtists =
        _attachTrackAndAlbum(artists.albumArtists, track, album);
    final albumWithArtists = album?.copyWith(artists: albumArtists);

    final trackArtists =
        _attachTrackAndAlbum(artists.trackArtists, track, album);

    return track.copyWith(
      album: albumWithArtists,
      artists: {...trackArtists, ...albumArtists}.toList(),
      audioInfoSet: extractAudioInfoSet(),
    );
  }

  List<BaseArtist> _attachTrackAndAlbum(
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

  ArtistsFromFile extractArtists();

  BaseTrack? extractTrack();

  AudioInfoSet? extractAudioInfoSet();

  List<int>? extractCoverImageBytes();
}
