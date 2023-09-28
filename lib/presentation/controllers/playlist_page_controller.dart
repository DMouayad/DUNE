import 'package:dune/domain/audio/facades/music_facade.dart';

//
import 'package:dune/domain/audio/base_models/base_playlist.dart';

import 'base_item_controller.dart';

class PlaylistPageController extends BaseItemPageController<BasePlaylist> {
  PlaylistPageController()
      : super(
          getItemFromLocalSource:
              MusicFacade.playlists.getPlaylistFromLocalStorage,
          getItemFromOriginSource:
              MusicFacade.playlists.getPlaylistFromOriginSource,
          localItemEqualsOrigin: (a, b) => a?.hasSameTracksAsOther(b) ?? false,
        );
}
