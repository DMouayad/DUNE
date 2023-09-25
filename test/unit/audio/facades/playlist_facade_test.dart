import 'package:collection/collection.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/facades/music_facade.dart';
import 'package:dune/domain/audio/factories/playlist_factory.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/fake_repositories/fake_playlist_repository.dart';
import '../../../utils/isar_testing_utils.dart';

Future<PlaylistFacade> _setupFacadeWith({
  required FakePlaylistRepository youtubeRepository,
  FakePlaylistRepository? spotifyRepository,
}) async {
  return PlaylistFacade(
    youtubePlaylistRepository: youtubeRepository,
    spotifyPlaylistRepository: spotifyRepository,
    localPlaylistRepository: IsarTestingUtils.isarMusicRepo.playlists,
  );
}

final fakeYoutubePlaylistFactory =
    PlaylistFactory().setMusicSource(MusicSource.youtube);
final fakeSpotifyPlaylistFactory =
    PlaylistFactory().setMusicSource(MusicSource.spotify);

void main() {
  setUpAll(() async => await IsarTestingUtils.initIsarForTesting());
  setUp(() async => await IsarTestingUtils.refreshDatabase());
  group(
      'test it fetches items from YoutubeRepository when provided source is'
      '[MusicSource.youtube]', () {
    late final PlaylistFacade facade;
    final playlist = fakeYoutubePlaylistFactory.setTracksCount(20).create();
    final playlists =
        fakeYoutubePlaylistFactory.setTracksCount(10).createCount(10);
    setUpAll(() async {
      facade = await _setupFacadeWith(
        youtubeRepository: FakePlaylistRepository(
          findPlaylistResult: playlist.asResult,
          getCategoryPlaylistsResult: playlists.asResult,
        ),
      );
    });
    test(
        'it returns a playlist with a list of tracks with [MusicSource.youtube]',
        () async {
      final playlistResult = await facade.getPlaylistFromOriginSource(
        playlist.id!,
        MusicSource.youtube,
      );
      expectLater(playlistResult.isSuccess, true);
      expectLater(
        playlistResult.requireValue?.tracks
            .every((e) => e.source == MusicSource.youtube),
        true,
      );
    });
    test(
        'it returns a list of playlists with source equals to [MusicSource.youtube]',
        () async {
      final playlistsResult = await facade.getCategoryPlaylists(
        "someID",
        MusicSource.youtube,
      );
      expectLater(playlistsResult.isSuccess, true);
      expectLater(
        playlistsResult.requireValue
            ?.every((e) => e.musicSource == MusicSource.youtube),
        true,
      );
    });
  });
  group('it saves fetched items from a remote repository into the local one',
      () {
    late PlaylistFacade facade;
    final youtubePlaylist =
        fakeYoutubePlaylistFactory.setTracksCount(20).create();
    final youtubePlaylists =
        fakeYoutubePlaylistFactory.setTracksCount(10).createCount(10);
    final spotifyPlaylist =
        fakeSpotifyPlaylistFactory.setTracksCount(10).create();
    final spotifyPlaylists =
        fakeSpotifyPlaylistFactory.setTracksCount(10).createCount(20);

    setUp(() async {
      facade = await _setupFacadeWith(
        youtubeRepository: FakePlaylistRepository(
          findPlaylistResult: youtubePlaylist.asResult,
          getCategoryPlaylistsResult: youtubePlaylists.asResult,
        ),
        spotifyRepository: FakePlaylistRepository(
          findPlaylistResult: spotifyPlaylist.asResult,
          getCategoryPlaylistsResult: spotifyPlaylists.asResult,
        ),
      );
    });
    test(
      'it saves playlist data after its fetched from [youtubePlaylistRepository]',
      () async {
        final result = await facade.getPlaylistFromOriginSource(
            youtubePlaylist.id!, MusicSource.youtube);
        expectLater(result.isSuccess, true);
        // assert playlist was fetched from youtube source
        expectLater(result.requireValue, youtubePlaylist);
        // wait for the playlist to be saved in the local DB
        await Future.delayed(const Duration(seconds: 1));
        //
        final fetchingLocalPlaylistResult =
            await facade.getPlaylistFromLocalStorage(youtubePlaylist.id!);
        expectLater(fetchingLocalPlaylistResult.isSuccess, true);
        assertPlaylistsHasSameProps(
            fetchingLocalPlaylistResult.requireValue, youtubePlaylist);
      },
    );
    test(
      'it saves playlist data after its fetched from [spotifyPlaylistRepository]',
      () async {
        final fetchingRemotePlaylistResult =
            await facade.getPlaylistFromOriginSource(
                spotifyPlaylist.id!, MusicSource.spotify);
        expectLater(fetchingRemotePlaylistResult.isSuccess, true);
        // assert playlist was fetched from youtube source
        expectLater(fetchingRemotePlaylistResult.requireValue, spotifyPlaylist);
        // wait for the playlist to be saved in the local repo
        await Future.delayed(const Duration(seconds: 1));
        //
        final fetchingLocalPlaylistResult =
            await facade.getPlaylistFromLocalStorage(spotifyPlaylist.id!);
        expectLater(fetchingLocalPlaylistResult.isSuccess, true);
        assertPlaylistsHasSameProps(
          fetchingLocalPlaylistResult.requireValue,
          fetchingRemotePlaylistResult.requireValue!,
        );
      },
    );
    test(
      'it saves category playlists data after its fetched from [spotifyPlaylistRepository]',
      () async {
        const categoryId = 'someID';
        final result =
            await facade.getCategoryPlaylists(categoryId, MusicSource.spotify);
        expectLater(result.isSuccess, true);
        // assert the playlists were fetched from the youtube source
        expectLater(result.requireValue, spotifyPlaylists);
        // wait for the playlists to be saved in the local DB
        await Future.delayed(const Duration(seconds: 2));
        //
        final localPlaylistsResult =
            await facade.getCategoryPlaylistsFromLocalStorage(categoryId);
        expectLater(localPlaylistsResult.isSuccess, true);
        expectLater(localPlaylistsResult.requireValue != null, true);
        assertTwoListsHaveSamePlaylists(
          localPlaylistsResult.requireValue!,
          spotifyPlaylists,
        );
      },
    );
    test(
      'it saves category playlists data after its fetched from [youtubePlaylistRepository]',
      () async {
        const categoryId = 'someID';
        final result =
            await facade.getCategoryPlaylists(categoryId, MusicSource.youtube);
        expectLater(result.isSuccess, true);
        // assert the playlists were fetched from the youtube source
        expectLater(result.requireValue, youtubePlaylists);
        // wait for the playlists to be saved in the local DB
        await Future.delayed(const Duration(seconds: 2));
        //
        final localPlaylistsResult =
            await facade.getCategoryPlaylistsFromLocalStorage(categoryId);
        expectLater(localPlaylistsResult.isSuccess, true);
        expectLater(localPlaylistsResult.requireValue != null, true);
        assertTwoListsHaveSamePlaylists(
          localPlaylistsResult.requireValue!,
          youtubePlaylists,
        );
      },
    );
  });
}

void assertTwoListsHaveSamePlaylists(
  List<BasePlaylist> first,
  List<BasePlaylist> second,
) {
  final firstPlaylistsIds = first.map((e) => e.id).toList();
  final secondPlaylistsIds = second.map((e) => e.id).toList();
  expectLater(
      const ListEquality().equals(firstPlaylistsIds, secondPlaylistsIds), true);
}

void assertPlaylistsHasSameProps(BasePlaylist? actual, BasePlaylist matcher) {
  expectLater(actual?.id, matcher.id);
  expectLater(actual?.musicSource, matcher.musicSource);
  expectLater(actual?.title, matcher.title);
  expectLater(actual?.description, matcher.description);
  expectLater(actual?.thumbnails, matcher.thumbnails);
  expectLater(actual?.tracks.length, matcher.tracks.length);
}
