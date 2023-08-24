import 'package:collection/collection.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';

class EqualityHelper {
  static bool playlistsHasSameProps(BasePlaylist first, BasePlaylist second) {
    final firstProps = List<Object?>.from(first.props);
    final secondProps = List<Object?>.from(second.props);
    // tracks are removed because each track( relations(album, artists)
    // and their relations also) don't always get loaded for every playlist.
    // and we only want to verify if the two [BasePlaylist] instances has
    // the same tracks be asserting they have the same tracks ids.
    firstProps.remove(first.tracks);
    secondProps.remove(second.tracks);
    final firstTracksIds = first.tracks.map((e) => e.id).toList();
    final secondTracksIds = second.tracks.map((e) => e.id).toList();
    final hasSameTracksIds =
        const ListEquality().equals(firstTracksIds, secondTracksIds);
    // the thumbnails as a [ThumbnailsSet] object also ignored and we verify the
    // two thumbnail sets items are equals
    firstProps.remove(first.thumbnails);
    secondProps.remove(second.thumbnails);
    final hasSameThumbnails = const ListEquality()
        .equals(first.thumbnails.thumbnails, second.thumbnails.thumbnails);

    return const ListEquality().equals(firstProps, secondProps) &&
        hasSameThumbnails &&
        hasSameTracksIds;
  }

  static bool tracksHistoriesHasSameProps(
      BaseTrackListeningHistory first, BaseTrackListeningHistory second) {
    return (first.date == second.date) &&
        (first.uncompletedListensTotalDuration ==
            second.uncompletedListensTotalDuration) &&
        (first.completedListensCount == second.completedListensCount) &&
        (first.track!.id == second.track!.id);
  }

  static bool tracksHasSameArtists(BaseTrack first, BaseTrack second) {
    if (first.artists.length != second.artists.length) {
      return false;
    }
    for (int i = 0; i < first.artists.length; i++) {
      if (artistsHasSameProps(
          first.artists.elementAt(i), second.artists.elementAt(i))) {
        // do nothing
      } else {
        return false;
      }
    }
    return true;
  }

  static bool albumsHasSameProps(BaseAlbum? first, BaseAlbum? second) {
    final firstProps = List.from(first?.props ?? []);
    firstProps.remove(first?.artists);
    firstProps.remove(first?.tracks);
    final secondProps = List.from(second?.props ?? []);
    secondProps.remove(second?.artists);
    secondProps.remove(second?.tracks);

    return const ListEquality().equals(firstProps, secondProps);
  }

  static bool artistsHasSameProps(BaseArtist first, BaseArtist second) {
    final firstProps = List.from(first.props);
    firstProps.remove(first.tracks);
    firstProps.remove(first.albums);
    final secondProps = List.from(second.props);
    secondProps.remove(second.albums);
    secondProps.remove(second.tracks);

    return const ListEquality().equals(firstProps, secondProps);
  }

  static List<String> _extractTracksIds(List<BaseTrack> items) {
    return items.map((e) => e.id).toSet().toList();
  }

  static List<String> _extractPlaylistsIds(List<BasePlaylist> items) {
    return items.map((e) => e.id!).toSet().toList();
  }

  static List<String> _extractAlbumsIds(List<BaseAlbum> items) {
    return items.map((e) => e.id!).toSet().toList();
  }

  static List<String> _extractArtistsIds(List<BaseArtist> items) {
    return items.map((e) => e.id!).toSet().toList();
  }

  static bool playlistListsHaveSameIds(
    List<BasePlaylist> first,
    List<BasePlaylist> second,
  ) {
    return const UnorderedIterableEquality()
        .equals(_extractPlaylistsIds(first), _extractPlaylistsIds(second));
  }

  static bool trackListsHaveSameIds(
      List<BaseTrack> first, List<BaseTrack> second) {
    return const UnorderedIterableEquality()
        .equals(_extractTracksIds(first), _extractTracksIds(second));
  }

  static bool artistListsHaveSameIds(
      List<BaseArtist> first, List<BaseArtist> second) {
    return const UnorderedIterableEquality()
        .equals(_extractArtistsIds(first), _extractArtistsIds(second));
  }

  static bool albumListsHaveSameIds(
    List<BaseAlbum> first,
    List<BaseAlbum> second,
  ) {
    return const UnorderedIterableEquality()
        .equals(_extractAlbumsIds(first), _extractAlbumsIds(second));
  }
}
