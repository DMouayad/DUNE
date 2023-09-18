part of app_router;

class RoutePath {
  static const String explorePage = '/explore',
      settingsPage = '/settings',
      listeningHistoryPage = '/listening-history',
      libraryPage = '/library',
      playlistPage = 'playlist/:playlistId',
      exploreMusicCategoryPage = 'explore-music-category/:categoryId',
      desktopSplashScreenPage = '/desktop-splash-screen';
}

class RouteName {
  static const String explorePage = 'Explore',
      settingsPage = 'Settings',
      listeningHistoryPage = 'Listening History',
      libraryPage = 'My Library',
      playlistPage = 'Playlist';
}

enum QuickNavDestination {
  explorePage(0, RoutePath.explorePage),
  listeningHistoryPage(1, RoutePath.listeningHistoryPage),
  libraryPage(2, RoutePath.libraryPage),
  settingsPage(3, RoutePath.settingsPage);

  const QuickNavDestination(this.destinationIndex, this.path);

  final int destinationIndex;
  final String path;
}
