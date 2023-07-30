import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/domain/audio/base_models/base_playlists_listening_history.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:faker/faker.dart';

import 'package:dune/domain/audio/factories/base_model_factory.dart';
import 'fake_playlist.dart';

final class FakePlaylistsListeningHistory
    extends BasePlaylistsListeningHistory {
  FakePlaylistsListeningHistory({
    required super.date,
    required super.playlists,
  });

  @override
  BasePlaylistsListeningHistory addPlaylists(List<BasePlaylist> playlists) {
    // TODO: implement addPlaylists
    throw UnimplementedError();
  }
}
