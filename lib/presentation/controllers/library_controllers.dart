import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/facades/music_facade.dart';

import 'base_paged_items_controller.dart';

class LocalLibraryTracksController extends PagedItemsController<BaseTrack> {
  LocalLibraryTracksController()
      : super(
          onLoadItems: (queryOptions) async =>
              await MusicFacade.localMusicLibrary.getTracks(queryOptions),
        );
}

class LocalLibraryAlbumsController extends PagedItemsController<BaseAlbum> {
  LocalLibraryAlbumsController()
      : super(
          onLoadItems: (queryOptions) async =>
              await MusicFacade.localMusicLibrary.getAlbums(queryOptions),
        );
}

class LocalLibraryArtistsController extends PagedItemsController<BaseArtist> {
  LocalLibraryArtistsController()
      : super(
          onLoadItems: (queryOptions) async =>
              await MusicFacade.localMusicLibrary.getArtists(queryOptions),
        );
}
