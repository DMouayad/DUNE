import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/presentation/providers/state_controllers.dart';

import 'base_item_with_tracks_page.dart';

class ArtistPage extends BaseItemWithTracksPage<BaseArtist> {
  ArtistPage({
    super.key,
    required BaseArtist artist,
  }) : super(
          item: artist,
          itemControllerProvider: artistPageControllerProvider,
        ) {
    for (var track in artist.tracks) {
      print(track.album);
      print(track.artistsNames);
    }
  }
}
