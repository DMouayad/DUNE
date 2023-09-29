part of app_router;

class AlbumPageRoute extends GoRoute {
  AlbumPageRoute() : super(path: RoutePath.albumPage, builder: buildPage);

  static Widget buildPage(BuildContext context, GoRouterState state) {
    return PageBodyWrapper(
      child: AlbumPage(key: state.pageKey, artist: state.extra as BaseAlbum),
    );
  }
}
