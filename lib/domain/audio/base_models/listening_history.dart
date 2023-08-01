import 'package:dune/domain/audio/base_models/base_playlists_listening_history.dart';
import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:equatable/equatable.dart';

import 'base_album.dart';
import 'base_artist.dart';

class DateListeningHistory extends Equatable
    with ListeningHistoryDataExtractor {
  late final DateTime date;

  /// The listening histories of all tracks
  /// which were listened-to on the specified [date]
  final List<BaseTrackListeningHistory> tracksListeningHistory;
  final BasePlaylistsListeningHistory? playlistsListeningHistory;

  /// List of artists which were listened-to on the specified [date]
  late final List<BaseArtist> artists;

  /// List of albums which were listened-from on the specified [date]
  late final List<BaseAlbum> albums;

  DateListeningHistory({
    required DateTime date,
    required this.tracksListeningHistory,
    this.playlistsListeningHistory,
  }) {
    this.date = date.onlyDate;
    albums = getAlbumsFromTracks(tracksListeningHistory);
    artists = getArtistsFromTracks(tracksListeningHistory);
  }

  DateListeningHistory copyWithTrackListeningHistoryAdded(
    BaseTrackListeningHistory trackListeningHistory,
  ) {
    final updatedTracksListeningHistory =
        List<BaseTrackListeningHistory>.from(tracksListeningHistory);
    // get the index of a [BaseTrackListeningHistory] for the
    // [trackListeningHistory] track and date.
    final index = updatedTracksListeningHistory.indexWhere((e) =>
        e.date == trackListeningHistory.date &&
        e.track?.id == trackListeningHistory.track?.id);

    if (index == -1) {
      // if no track listening present, just add it to the end.
      updatedTracksListeningHistory.add(trackListeningHistory);
    } else {
      // else replace the history at [index] with the new value
      updatedTracksListeningHistory[index] = trackListeningHistory;
    }
    return copyWith(tracksListeningHistory: updatedTracksListeningHistory);
  }

  DateListeningHistory copyWith({
    DateTime? date,
    List<BaseTrackListeningHistory>? tracksListeningHistory,
    BasePlaylistsListeningHistory? playlistsListeningHistory,
  }) {
    return DateListeningHistory(
      date: date ?? this.date,
      tracksListeningHistory:
          tracksListeningHistory ?? this.tracksListeningHistory,
      playlistsListeningHistory:
          playlistsListeningHistory ?? this.playlistsListeningHistory,
    );
  }

  DateListeningHistory copyWithPlaylistHistoryAdded(
    BasePlaylistsListeningHistory history,
  ) {
    return copyWith(
      playlistsListeningHistory:
          playlistsListeningHistory?.addPlaylists(history.playlists),
    );
  }

  @override
  List<Object?> get props =>
      [date, tracksListeningHistory, playlistsListeningHistory];

// DateListeningHistory copyWithPlaylistsListeningHistoryAdded(
//   BasePlaylistsListeningHistory history,
// ) {
//   final updatedPlaylistsListeningHistory =
//       List<BasePlaylistsListeningHistory>.from(playlistsListeningHistory);
//   // get the index of a [BasePlaylistListeningHistory] for the
//   // [history] playlist and date.
//   final index = updatedPlaylistsListeningHistory
//       .indexWhere((e) => e.date == history.date);
//
//   if (index == -1) {
//     // if no playlists listening history present, just add it to the end.
//     updatedPlaylistsListeningHistory.add(history);
//   } else {
//     // else replace the history at [index] with the new value
//     updatedPlaylistsListeningHistory[index] = history;
//   }
//   return copyWith(
//       playlistsListeningHistory: updatedPlaylistsListeningHistory);
// }
}

mixin ListeningHistoryDataExtractor {
  List<BaseAlbum> getAlbumsFromTracks(
      List<BaseTrackListeningHistory> tracksListeningHistory) {
    final albumsList = <BaseAlbum>[];
    for (BaseTrackListeningHistory listeningHistory in tracksListeningHistory) {
      if (listeningHistory.track?.album != null) {
        final alreadyAdded = albumsList.firstWhereOrNull(
                (e) => e.id == listeningHistory.track!.album!.id) !=
            null;
        if (!alreadyAdded) {
          albumsList.add(listeningHistory.track!.album!);
        }
      }
    }
    return albumsList;
  }

  List<BaseArtist> getArtistsFromTracks(
      List<BaseTrackListeningHistory> tracks) {
    final artists = <BaseArtist>[];
    for (BaseTrackListeningHistory listeningHistory in tracks) {
      if (listeningHistory.track?.artists != null) {
        artists.addAll(listeningHistory.track!.artists);
      }
    }
    return artists.toSet().toList();
  }
}

class ListeningHistoryCollection {
  late final Map<DateTime, DateListeningHistory> _itemsMap;
  Map<DateTime, DateListeningHistory> get histories => _itemsMap;

  ListeningHistoryCollection(List<DateListeningHistory> items) {
    _itemsMap = Map.fromEntries(items.map((e) => MapEntry(e.date.onlyDate, e)));
  }

  bool historyExistsForDay(DateTime date) =>
      _itemsMap.containsKey(date.onlyDate);

  DateListeningHistory? getWhereDate(DateTime date) =>
      _itemsMap.whereKey(date.onlyDate);

  void replaceHistory(DateListeningHistory newHistory) {
    _itemsMap[newHistory.date.onlyDate] = newHistory;
  }

  Map<DateTime, List<BaseAlbum>> get albumsListeningHistory {
    return Map.fromEntries(
      _itemsMap.entries
          .where((e) => e.value.albums.isNotEmpty)
          .map((e) => MapEntry(e.key, e.value.albums)),
    );
  }

  Map<DateTime, BasePlaylistsListeningHistory> get playlistsListeningHistory {
    return Map.fromEntries(
      _itemsMap.entries
          .where((e) =>
              e.value.playlistsListeningHistory?.playlists.isNotEmpty ?? false)
          .map((e) => MapEntry(e.key, e.value.playlistsListeningHistory!)),
    );
  }

  Map<DateTime, List<BaseTrackListeningHistory>> get tracksListeningHistory {
    return Map.fromEntries(
      _itemsMap.entries
          .where((e) => e.value.tracksListeningHistory.isNotEmpty)
          .map((e) => MapEntry(e.key, e.value.tracksListeningHistory)),
    );
  }

  Map<DateTime, List<BaseArtist>> get artistsListeningHistory {
    return Map.fromEntries(
      _itemsMap.entries
          .where((e) => e.value.artists.isNotEmpty)
          .map((e) => MapEntry(e.key, e.value.artists)),
    );
  }
}
