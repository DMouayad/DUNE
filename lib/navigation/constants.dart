part of app_router;

class RoutePath {
  static const String explorePage = '/explore',
      settingsPage = '/settings',
      listeningHistoryPage = '/listening-history',
      libraryTracksPage = '/library/tracks',
      libraryAlbumsPage = '/library/albums',
      libraryArtistsPage = '/library/artists',
      libraryFoldersPage = '/library/folders',
      playlistPage = 'playlist/:playlistId',
      exploreMusicCategoryPage = 'explore-music-category/:categoryId',
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
  settingsPage(2, RoutePath.settingsPage),
  libraryTracksPage(3, RoutePath.libraryTracksPage),
  libraryAlbumsPage(3, RoutePath.libraryAlbumsPage),
  libraryArtistsPage(3, RoutePath.libraryArtistsPage),
  libraryFoldersPage(3, RoutePath.libraryFoldersPage);

  const QuickNavDestination(this.destinationIndex, this.path);

  final int destinationIndex;
  final String path;
}
