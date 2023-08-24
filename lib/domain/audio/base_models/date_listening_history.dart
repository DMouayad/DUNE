part of 'listening_history_collection.dart';

class DateListeningHistory extends Equatable
    with ListeningHistoryDataExtractor {
  late final DateTime date;

  /// The listening histories of tracks which were listened-to on
  /// the specified [date]
  final List<BaseTrackListeningHistory> tracks;
  final BasePlaylistsListeningHistory? playlists;

  /// List of artists which were listened-to on the specified [date]
  late final List<BaseArtist> artists;

  /// List of albums which were listened-from on the specified [date]
  late final List<BaseAlbum> albums;

  DateListeningHistory({
    required DateTime date,
    required this.tracks,
    this.playlists,
  }) {
    this.date = date.onlyDate;
    albums = getAlbumsFromTracks(tracks);
    artists = getArtistsFromTracks(tracks);
  }

  DateListeningHistory copyWithTrackListeningHistoryAdded(
    BaseTrackListeningHistory trackListeningHistory,
  ) {
    final updatedTracksListeningHistory =
        List<BaseTrackListeningHistory>.from(tracks);
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
    return copyWith(tracks: updatedTracksListeningHistory);
  }

  DateListeningHistory copyWith({
    DateTime? date,
    List<BaseTrackListeningHistory>? tracks,
    BasePlaylistsListeningHistory? playlists,
  }) {
    return DateListeningHistory(
      date: date ?? this.date,
      tracks: tracks ?? this.tracks,
      playlists: playlists ?? this.playlists,
    );
  }

  DateListeningHistory copyWithPlaylistHistoryAdded(
    BasePlaylistsListeningHistory history,
  ) {
    return copyWith(
      playlists: playlists == null
          ? history
          : playlists!.copyWithAddedPlaylists(history.items),
    );
  }

  @override
  List<Object?> get props => [date, tracks, playlists];
}

mixin ListeningHistoryDataExtractor {
  List<BaseAlbum> getAlbumsFromTracks(
    List<BaseTrackListeningHistory> histories,
  ) {
    final albumsList = <BaseAlbum>{};
    for (var history in histories) {
      if (history.track?.album != null) {
        albumsList.add(history.track!.album!);
      }
    }
    return albumsList.toList();
  }

  List<BaseArtist> getArtistsFromTracks(
    List<BaseTrackListeningHistory> histories,
  ) {
    final artists = <BaseArtist>{};
    for (var history in histories) {
      if (history.track?.artists != null) {
        artists.addAll(history.track!.artists);
      }
    }
    return artists.toList();
  }
}
