import 'package:dune/domain/audio/base_models/base_play_history.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/facades/music_facade.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListeningHistoryController
    extends StateNotifier<AsyncValue<List<BaseListeningHistory>>> {
  ListeningHistoryController() : super(const AsyncValue.data([]));

  Future<void> loadListeningHistoryOnDay(DateTime day) async {}

  Future<void> loadListeningHistoryOnDays(List<DateTime> days) async {}

  Future<void> loadListeningHistoryOverLastWeek() async {
    state = const AsyncValue<List<BaseListeningHistory>>.loading()
        .copyWithPrevious(state);
    final days = List.generate(DateTime.daysPerWeek, (i) => i)
        .map((dayIndex) =>
            DateTime.now().subtract(Duration(days: dayIndex)).onlyDate)
        .toList();
    (await MusicFacade.userListeningHistory.getListeningHistoryByDates(days))
        .fold(
      ifSuccess: (value) => state = AsyncValue.data(value),
      ifFailure: (error) => state = AsyncValue.error(error, error.stackTrace),
    );
  }

  Future<void> incrementTodayTrackCompletedListensCount(BaseTrack track) async {
    (await MusicFacade.userListeningHistory
            .incrementTrackCompletedListensCount(track, DateTime.now()))
        .fold(ifSuccess: _addToState);
  }

  Future<void> addToTodayTrackUncompletedListensDuration(
    BaseTrack track,
    Duration duration,
  ) async {
    (await MusicFacade.userListeningHistory
            .addToTrackUncompletedListensDuration(
      track,
      DateTime.now(),
      duration,
    ))
        .fold(ifSuccess: _addToState);
  }

  void _addToState(BaseListeningHistory history) {
    if (state.hasValue) {
      List<BaseListeningHistory> histories = List.from(state.requireValue);
      histories.removeWhere((e) => e.date == history.date);
      histories.add(history);
      state = AsyncValue.data(histories);
    }
  }

  Future<void> addPlaylistToTodayListeningHistory(
    BasePlaylist<BaseTrack> playlist,
  ) async {
    (await MusicFacade.userListeningHistory
            .addPlaylist(playlist, DateTime.now().onlyDate))
        .fold(ifSuccess: _addToState);
  }
}
