part of 'music_facade.dart';

final class UserListeningHistoryFacade {
  final BaseUserListeningHistoryRepository _repository;

  UserListeningHistoryFacade(this._repository);

  FutureResult<BaseListeningHistory> incrementTrackCompletedListensCount(
    BaseTrack track,
    DateTime date,
  ) async {
    return await _repository.incrementTrackCompletedListensCount(track, date);
  }

  FutureResult<BaseListeningHistory> addToTrackUncompletedListensDuration(
    BaseTrack track,
    DateTime date,
    Duration duration,
  ) async {
    return await _repository.addToTrackUncompletedListensDuration(
        track, date, duration);
  }

  FutureOrResult<List<BaseListeningHistory<BaseTrackRecord, BasePlaylist>>>
      getListeningHistoryByDates(
    List<DateTime> dates,
  ) async {
    return await _repository.getByDates(dates.map((e) => e.onlyDate).toList());
  }

  FutureResult<BaseListeningHistory> addPlaylist(
    BasePlaylist<BaseTrack<BaseAlbum, BaseArtist>> playlist,
    DateTime date,
  ) async {
    return await _repository.addPlaylist(playlist, date);
  }
}
