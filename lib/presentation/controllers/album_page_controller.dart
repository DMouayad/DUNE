import 'package:collection/collection.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/facades/music_facade.dart';
import 'package:dune/presentation/controllers/base_item_controller.dart';

class AlbumPageController extends BaseItemPageController<BaseAlbum> {
  AlbumPageController()
      : super(
          getItemFromLocalSource: MusicFacade.albums.getAlbumFromLocalStorage,
          getItemFromOriginSource: MusicFacade.albums.getAlbumFromOriginSource,
          localItemEqualsOrigin: (a, b) => a?.hasSameTracksAsOther(b) ?? false,
        );
}

extension AlbumEquality on BaseAlbum {
  bool hasSameTracksAsOther(BaseAlbum? other) {
    final firstTracksIds = tracks.map((e) => (e.id, e.album?.id)).toList();
    final secondTracksIds =
        other?.tracks.map((e) => (e.id, e.album?.id)).toList();
    return const ListEquality().equals(firstTracksIds, secondTracksIds);
  }
}
