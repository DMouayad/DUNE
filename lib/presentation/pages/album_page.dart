import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/presentation/providers/state_controllers.dart';

import 'base_item_with_tracks_page.dart';

class AlbumPage extends BaseItemWithTracksPage<BaseAlbum> {
  AlbumPage({
    super.key,
    required BaseAlbum artist,
  }) : super(
          item: artist,
          itemControllerProvider: albumPageControllerProvider,
        );
}
