import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/presentation/providers/state_controllers.dart';

import 'base_item_with_tracks_page.dart';

class PlaylistPage extends BaseItemWithTracksPage<BasePlaylist> {
  PlaylistPage({
    super.key,
    BasePlaylist? playlist,
    required String playlistId,
    required super.musicSource,
    super.description,
    super.thumbnails,
    super.title,
    super.tracksCount,
  }) : super(
          itemId: playlistId,
          descriptionFromItem: (playlist) => playlist?.description,
          idFromItem: (playlist) => playlist?.id,
          thumbnailsFromItem: (playlist) => playlist?.thumbnails,
          itemControllerProvider: playlistControllerProvider,
          titleFromItem: (playlist) => playlist?.title,
          tracksFromItem: (playlist) => playlist?.tracks ?? [],
        ) {
    print(playlist);
  }
}
