import 'package:dune/domain/audio/base_models/base_playlists_listening_history.dart';
import 'package:dune/domain/audio/base_models/base_track_listening_history.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:equatable/equatable.dart';

import 'base_album.dart';
import 'base_artist.dart';

part 'date_listening_history.dart';

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
          .where((e) => e.value.playlists?.items.isNotEmpty ?? false)
          .map((e) => MapEntry(e.key, e.value.playlists!)),
    );
  }

  Map<DateTime, List<BaseTrackListeningHistory>> get tracksListeningHistory {
    return Map.fromEntries(
      _itemsMap.entries
          .where((e) => e.value.tracks.isNotEmpty)
          .map((e) => MapEntry(e.key, e.value.tracks)),
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
