import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/presentation/providers/state_controllers.dart';

import 'base_item_with_tracks_page.dart';

class PlaylistPage extends BaseItemWithTracksPage<BasePlaylist> {
  PlaylistPage({
    super.key,
    required BasePlaylist playlist,
  }) : super(
          item: playlist,
          itemControllerProvider: playlistControllerProvider,
        );
}
