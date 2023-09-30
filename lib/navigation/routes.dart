import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/navigation/app_router.dart';
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
import 'package:dune/presentation/screens/desktop_splash_screen.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes/base_route.dart';
import 'routes/page_with_transition_builder.dart';

class DesktopSplashScreenRoute extends GoRoute {
  DesktopSplashScreenRoute()
      : super(
          path: RoutePath.desktopSplashScreenPage,
          builder: _build,
          redirect: (context, state) async {
            if (context.isDesktopPlatform) {
              return null;
            } else {
              return AppRouter.initialAppPage.path;
            }
          },
        );

  static Widget _build(BuildContext context, GoRouterState state) {
    return const DesktopSplashScreen();
  }
}

class LibraryTracksPageRoute extends BaseQuickNavDestinationRoute {
  LibraryTracksPageRoute({
    super.name,
    super.isSubRoute,
    super.routes,
  }) : super(
          index: QuickNavDestination.libraryTracksPage,
          path: RoutePath.libraryTracksPage,
          page: (context, state) => const LibraryTracksPage(),
        );
}

class LibraryAlbumsPageRoute extends BaseQuickNavDestinationRoute {
  LibraryAlbumsPageRoute({
    super.name,
    super.isSubRoute,
    super.routes,
  }) : super(
          index: QuickNavDestination.libraryAlbumsPage,
          path: RoutePath.libraryAlbumsPage,
          page: (context, state) => const LibraryAlbumsPage(),
        );
}

class LibraryArtistsPageRoute extends BaseQuickNavDestinationRoute {
  LibraryArtistsPageRoute({
    super.name,
    super.isSubRoute,
    super.routes,
  }) : super(
          index: QuickNavDestination.libraryArtistsPage,
          path: RoutePath.libraryArtistsPage,
          page: (context, state) => const LibraryArtistsPage(),
        );
}

class LibraryFoldersPageRoute extends BaseQuickNavDestinationRoute {
  LibraryFoldersPageRoute({
    super.name,
    super.isSubRoute,
    super.routes,
  }) : super(
          index: QuickNavDestination.libraryFoldersPage,
          path: RoutePath.libraryFoldersPage,
          page: (context, state) => const LibraryFoldersPage(),
        );
}

class ExplorePageRoute extends BaseQuickNavDestinationRoute {
  ExplorePageRoute({
    super.name,
    super.isSubRoute,
    super.routes,
  }) : super(
          index: QuickNavDestination.explorePage,
          path: RoutePath.explorePage,
          page: (context, state) => const ExplorePage(),
        );
}

class ListeningHistoryPageRoute extends BaseQuickNavDestinationRoute {
  ListeningHistoryPageRoute({
    super.name,
    super.isSubRoute,
    super.routes,
  }) : super(
          index: QuickNavDestination.listeningHistoryPage,
          path: RoutePath.listeningHistoryPage,
          page: (context, state) => const ListeningHistoryPage(),
        );
}

class AlbumPageRoute extends BaseRoute {
  AlbumPageRoute({super.isSubRoute})
      : super(
          pageBuilder: const PageWithSlideInTransitionBuilder(),
          path: RoutePath.albumPage,
          page: (context, state) =>
              AlbumPage(key: state.pageKey, artist: state.extra as BaseAlbum),
        );
}

class ArtistPageRoute extends BaseRoute {
  ArtistPageRoute({super.isSubRoute})
      : super(
          path: RoutePath.artistPage,
          page: (context, state) =>
              ArtistPage(key: state.pageKey, artist: state.extra as BaseArtist),
          pageBuilder: const PageWithSlideInTransitionBuilder(),
        );
}

class PlaylistPageRoute extends BaseRoute {
  PlaylistPageRoute({super.isSubRoute})
      : super(
          pageBuilder: const PageWithSlideInTransitionBuilder(),
          path: RoutePath.playlistPage,
          page: (context, state) => PlaylistPage(
              key: state.pageKey, playlist: state.extra as BasePlaylist),
        );
}

class ExploreMusicCategoryPageRoute extends BaseRoute {
  ExploreMusicCategoryPageRoute({super.isSubRoute})
      : super(
          path: RoutePath.exploreMusicCategoryPage,
          page: (context, state) => ExploreMusicCategoryPage(
            key: state.pageKey,
            categoryId: state.pathParameters['categoryId'],
            title: state.pathParameters['title'],
          ),
        );
}
