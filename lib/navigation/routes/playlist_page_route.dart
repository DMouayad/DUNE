part of app_router;

class PlaylistPageRoute extends GoRoute {
  PlaylistPageRoute()
      : super(path: RoutePath.playlistPage, pageBuilder: buildPage);

  static Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      child: PageBodyWrapper(
        child: PlaylistPage(
            key: state.pageKey, playlist: state.extra as BasePlaylist),
      ),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        // Fractional offset from 1/4 screen below the top to fully on screen.
        final Tween<Offset> bottomUpTween =
            Tween<Offset>(begin: const Offset(0.0, 0.25), end: Offset.zero);
        final Animatable<double> fastOutSlowInTween =
            CurveTween(curve: Curves.fastOutSlowIn);
        final Animatable<double> easeInTween = CurveTween(curve: Curves.easeIn);

        return SlideTransition(
          position: animation.drive(bottomUpTween.chain(fastOutSlowInTween)),
          child: FadeTransition(
            opacity: animation.drive(easeInTween),
            child: child,
          ),
        );
      },
    );
  }
}
