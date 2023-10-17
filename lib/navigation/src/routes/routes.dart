import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/presentation/custom_widgets/new_tab_page.dart';
import 'package:dune/presentation/pages/album_page.dart';
import 'package:dune/presentation/pages/artist_page.dart';
import 'package:dune/presentation/pages/explore_music_category_page.dart';
import 'package:dune/presentation/pages/explore_page/explore_page.dart';
import 'package:dune/presentation/pages/library_page/library_albums_page.dart';
import 'package:dune/presentation/pages/library_page/library_artists_page.dart';
import 'package:dune/presentation/pages/library_page/library_folders_page.dart';
import 'package:dune/presentation/pages/library_page/library_tracks_page.dart';
import 'package:dune/presentation/pages/listening_history_page/listening_history_page.dart';
import 'package:dune/presentation/pages/playlist_page.dart';

import 'package:dune/navigation/navigation.dart';
import 'page_with_transition_builder.dart';

class LibraryTracksPageRoute extends BaseQuickNavDestinationRoute {
  LibraryTracksPageRoute()
      : super(
          name: RouteName.libraryTracksPage,
          index: QuickNavDestination.libraryTracksPage,
          path: RoutePath.libraryTracksPage,
          page: (context, state) => const LibraryTracksPage(),
        );
}

class LibraryAlbumsPageRoute extends BaseQuickNavDestinationRoute {
  LibraryAlbumsPageRoute()
      : super(
          name: RouteName.libraryAlbumsPage,
          index: QuickNavDestination.libraryAlbumsPage,
          path: RoutePath.libraryAlbumsPage,
          page: (context, state) => const LibraryAlbumsPage(),
        );
}

class LibraryArtistsPageRoute extends BaseQuickNavDestinationRoute {
  LibraryArtistsPageRoute()
      : super(
          name: RouteName.libraryArtistsPage,
          index: QuickNavDestination.libraryArtistsPage,
          path: RoutePath.libraryArtistsPage,
          page: (context, state) => const LibraryArtistsPage(),
        );
}

class LibraryFoldersPageRoute extends BaseQuickNavDestinationRoute {
  LibraryFoldersPageRoute()
      : super(
          name: RouteName.libraryFoldersPage,
          index: QuickNavDestination.libraryFoldersPage,
          path: RoutePath.libraryFoldersPage,
          page: (context, state) => const LibraryFoldersPage(),
        );
}

class ExplorePageRoute extends BaseQuickNavDestinationRoute {
  ExplorePageRoute()
      : super(
          name: RouteName.explorePage,
          index: QuickNavDestination.explorePage,
          path: RoutePath.explorePage,
          page: (context, state) => const ExplorePage(),
        );
}

class ListeningHistoryPageRoute extends BaseQuickNavDestinationRoute {
  ListeningHistoryPageRoute()
      : super(
          name: RouteName.listeningHistoryPage,
          index: QuickNavDestination.listeningHistoryPage,
          path: RoutePath.listeningHistoryPage,
          page: (context, state) => const ListeningHistoryPage(),
        );
}

class AlbumPageRoute extends BaseRoute {
  AlbumPageRoute()
      : super(
          pageBuilder: const PageWithSlideInTransitionBuilder(),
          path: RoutePath.albumPage,
          page: (context, state) =>
              AlbumPage(key: state.pageKey, artist: state.extra as BaseAlbum),
        );
}

class ArtistPageRoute extends BaseRoute {
  ArtistPageRoute()
      : super(
          path: RoutePath.artistPage,
          page: (context, state) =>
              ArtistPage(key: state.pageKey, artist: state.extra as BaseArtist),
          pageBuilder: const PageWithSlideInTransitionBuilder(),
        );
}

class PlaylistPageRoute extends BaseRoute {
  PlaylistPageRoute()
      : super(
          pageBuilder: const PageWithSlideInTransitionBuilder(),
          path: RoutePath.playlistPage,
          page: (context, state) => PlaylistPage(
              key: state.pageKey, playlist: state.extra as BasePlaylist),
        );
}

class ExploreMusicCategoryPageRoute extends BaseRoute {
  ExploreMusicCategoryPageRoute()
      : super(
          path: RoutePath.exploreMusicCategoryPage,
          page: (context, state) {
            return ExploreMusicCategoryPage(
              key: state.pageKey,
              categoryId: state.pathParameters['categoryId'],
              title: state.extra is String ? state.extra as String : null,
            );
          },
        );
}

class NewTabPageRoute extends BaseRoute {
  NewTabPageRoute()
      : super(
          name: RouteName.newTabPage,
          pageBuilder: const PageWithSlideInTransitionBuilder(),
          path: RoutePath.newTabPage,
          page: (context, state) => const NewTabPage(),
        );
}
