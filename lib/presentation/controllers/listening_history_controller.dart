import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/listening_history.dart';
import 'package:dune/domain/audio/facades/music_facade.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListeningHistoryController
    extends StateNotifier<AsyncValue<ListeningHistoryCollection>> {
  ListeningHistoryController()
      : super(
          AsyncValue.data(ListeningHistoryCollection([])),
        );

  Future<void> loadListeningHistoryOnDay(DateTime day) async {}

  Future<void> loadListeningHistoryOnDays(List<DateTime> days) async {}

  Future<void> loadListeningHistoryOverLastWeek() async {
    state = const AsyncValue<ListeningHistoryCollection>.loading()
        .copyWithPrevious(state);
    final days = List.generate(DateTime.daysPerWeek, (i) => i)
        .map((dayIndex) =>
            DateTime.now().subtract(Duration(days: dayIndex)).onlyDate)
        .toList();
    (await MusicFacade.userListeningHistory.getListeningHistoryByDates(days))
        .fold(
      onSuccess: (value) {
        state = AsyncValue.data(value);
      },
      onFailure: (error) => state = AsyncValue.error(error, error.stackTrace),
    );
  }

  Future<void> incrementTodayTrackCompletedListensCount(BaseTrack track) async {
    (await MusicFacade.userListeningHistory
            .incrementTrackCompletedListensCount(track, DateTime.now()))
        .fold(onSuccess: _updateState);
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
        .fold(onSuccess: _updateState);
  }

  void _updateState(ListeningHistoryCollection newCollection) {
    // if (state.hasValue)
    state = AsyncValue.data(newCollection);
  }

  Future<void> addPlaylistToTodayListeningHistory(
    BasePlaylist<BaseTrack> playlist,
  ) async {
    (await MusicFacade.userListeningHistory
            .addPlaylist(playlist, DateTime.now().onlyDate))
        .fold(onSuccess: _updateState);
  }
}
