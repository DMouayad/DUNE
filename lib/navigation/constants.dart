part of app_router;

class RoutePath {
  static const String explorePage = '/explore',
      searchPage = '/search',
      settingsPage = '/settings',
      listeningHistoryPage = '/listening-history',
      libraryPage = '/library',
      playlistPage = 'playlist/:playlistId',
      exploreMusicCategoryPage = 'explore-music-category/:categoryId',
      desktopSplashScreenPage = '/desktop-splash-screen';
}

class RouteName {
  static const String explorePage = 'Explore',
      searchPage = 'Search',
      settingsPage = 'Settings',
      listeningHistoryPage = 'Listening History',
      libraryPage = 'My Library',
      playlistPage = 'Playlist';
}

/// The indices of each ShellBranch-Route page in the HomePage
/// [StatefulShellRoute.indexedStack]
enum HomeNavigationShellBranchIndex {
  explorePage(0),
  searchPage(1),
  listeningHistoryPage(2),
  libraryPage(3),
  settingsPage(4);

  const HomeNavigationShellBranchIndex(this.value);

  static List<HomeNavigationShellBranchIndex> get navigationRailDestinations =>
      // Order must be the same as the nav rail destinations.
      [explorePage, searchPage, listeningHistoryPage, libraryPage];

  final int value;
}
