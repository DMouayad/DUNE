import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/listening_history_collection.dart';
import 'package:dune/domain/audio/facades/music_facade.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListeningHistoryController
    extends StateNotifier<AsyncValue<ListeningHistoryCollection>> {
  ListeningHistoryController()
      : super(
          AsyncValue.data(ListeningHistoryCollection([])),
        );

  Future<void> loadListeningHistoryOnDay(DateTime day) async {}

  Future<void> loadListeningHistoryOnDays(List<DateTime> days) async {}

  Future<void> loadListeningHistoryOverLastMonth() async {
    state = const AsyncValue<ListeningHistoryCollection>.loading()
        .copyWithPrevious(state);
    final now = DateTime.now();
    final dateRange = DateTimeRange(
        start: DateTime(now.year, now.month),
        end: DateTime(now.year, now.month, 31));
    (await MusicFacade.userListeningHistory
            .getListeningHistoryByRange(dateRange))
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
