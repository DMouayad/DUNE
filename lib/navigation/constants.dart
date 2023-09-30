part of app_router;

class RoutePath {
  static const String explorePage = '/explore',
      listeningHistoryPage = '/listening-history',
      libraryTracksPage = '/library/tracks',
      libraryAlbumsPage = '/library/albums',
      libraryArtistsPage = '/library/artists',
      libraryFoldersPage = '/library/folders',
      playlistPage = '/playlist/:playlistId',
      artistPage = '/artist/:artistId',
      albumPage = '/album/:albumId',
      exploreMusicCategoryPage = '/explore-music-category/:categoryId',
      desktopSplashScreenPage = '/desktop-splash-screen';
}

class RouteName {
  static const String explorePage = 'Explore',
      settingsPage = 'Settings',
      listeningHistoryPage = 'Listening History',
      libraryTracksPage = 'My library tracks',
      libraryAlbumsPage = 'My library albums',
      libraryArtistsPage = 'My library artists',
      libraryFoldersPage = 'My library folders',
      libraryPage = 'My Library',
      playlistPage = 'Playlist';
}

enum QuickNavDestination {
  explorePage(0, RoutePath.explorePage),
  listeningHistoryPage(1, RoutePath.listeningHistoryPage),
  libraryTracksPage(2, RoutePath.libraryTracksPage),
  libraryAlbumsPage(3, RoutePath.libraryAlbumsPage),
  libraryArtistsPage(4, RoutePath.libraryArtistsPage),
  libraryFoldersPage(5, RoutePath.libraryFoldersPage);

  const QuickNavDestination(this.destinationIndex, this.path);

  final int destinationIndex;
  final String path;
}
