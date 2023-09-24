part of app_router;

class LibraryTracksPageRoute extends BaseHomeScreenBodyRoute {
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

class LibraryAlbumsPageRoute extends BaseHomeScreenBodyRoute {
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

class LibraryArtistsPageRoute extends BaseHomeScreenBodyRoute {
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

class LibraryFoldersPageRoute extends BaseHomeScreenBodyRoute {
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
