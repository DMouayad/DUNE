part of app_router;

class ArtistPageRoute extends GoRoute {
  ArtistPageRoute() : super(path: RoutePath.artistPage, builder: buildPage);

  static Widget buildPage(BuildContext context, GoRouterState state) {
    return PageBodyWrapper(
      child: ArtistPage(key: state.pageKey, artist: state.extra as BaseArtist),
    );
  }
}
