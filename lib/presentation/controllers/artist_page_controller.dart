import 'package:collection/collection.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/facades/music_facade.dart';
import 'package:dune/presentation/controllers/base_item_controller.dart';

class ArtistPageController extends BaseItemPageController<BaseArtist> {
  ArtistPageController()
      : super(
          getItemFromLocalSource: MusicFacade.artists.getArtistFromLocalStorage,
          getItemFromOriginSource:
              MusicFacade.artists.getArtistFromOriginSource,
          localItemEqualsOrigin: (a, b) => a?.hasSameTracksAsOther(b) ?? false,
        );
}

extension ArtistEquality on BaseArtist {
  bool hasSameTracksAsOther(BaseArtist? other) {
    final firstTracksIds = tracks.map((e) => (e.id, e.album?.id)).toList();
    final secondTracksIds =
        other?.tracks.map((e) => (e.id, e.album?.id)).toList();
    return const ListEquality().equals(firstTracksIds, secondTracksIds);
  }
}
