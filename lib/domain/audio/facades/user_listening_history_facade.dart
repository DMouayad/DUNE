part of 'music_facade.dart';

final class UserListeningHistoryFacade {
  final ListeningHistoryRepository _repository;

  UserListeningHistoryFacade(this._repository);

  FutureResult<List<BaseTrackListeningHistory>> getDetailedHistoryForTrack(
    String trackId,
  ) async {
    return await _repository.getDetailedHistoryForTrack(trackId);
  }

  FutureResult<BaseListeningHistoryMonthSummary?> getMonthSummary({
    required int month,
    required int year,
  }) async {
    return await _repository.getMonthSummary(month: month, year: year);
  }

  FutureResult<ListeningHistoryCollection> incrementTrackCompletedListensCount(
    BaseTrack track,
    DateTime date,
  ) async {
    return await _repository.incrementTrackCompletedListensCount(track, date);
  }

  FutureResult<ListeningHistoryCollection> addToTrackUncompletedListensDuration(
    BaseTrack track,
    DateTime date,
    Duration duration,
  ) async {
    return await _repository.addToTrackUncompletedListensDuration(
        track, date, duration);
  }

  FutureOrResult<ListeningHistoryCollection> getListeningHistoryByDates(
    List<DateTime> dates,
  ) async {
    return await _repository.getByDates(dates.map((e) => e.onlyDate).toList());
  }

  FutureOrResult<ListeningHistoryCollection> getListeningHistoryByRange(
    DateTimeRange dateRange,
  ) async {
    return await _repository.getByRange(dateRange);
  }

  FutureResult<ListeningHistoryCollection> addPlaylist(
    BasePlaylist playlist,
    DateTime date,
  ) async {
    return await _repository.addPlaylist(playlist, date);
  }
}
