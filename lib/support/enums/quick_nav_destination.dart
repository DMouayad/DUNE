import 'package:dune/navigation/navigation.dart';

enum QuickNavDestination {
  explorePage(0, "Explore", RoutePath.explorePage),
  listeningHistoryPage(1, 'Listening history', RoutePath.listeningHistoryPage),
  libraryTracksPage(2, "Library tracks", RoutePath.libraryTracksPage),
  libraryAlbumsPage(3, "Library albums", RoutePath.libraryAlbumsPage),
  libraryArtistsPage(4, "Library artists", RoutePath.libraryArtistsPage),
  libraryFoldersPage(5, "Library folders", RoutePath.libraryFoldersPage);

  const QuickNavDestination(this.destinationIndex, this.title, this.path);

  final int destinationIndex;
  final String title;
  final String path;
}
