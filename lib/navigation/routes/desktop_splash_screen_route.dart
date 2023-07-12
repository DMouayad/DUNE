part of app_router;

class DesktopSplashScreenRoute extends GoRoute {
  DesktopSplashScreenRoute()
      : super(
          path: RoutePath.desktopSplashScreenPage,
          builder: _build,
          redirect: (context, state) {
            if (!context.isDesktopPlatform) {
              return AppRouter.initialLocation;
            }
            return null;
          },
        );

  static Widget _build(BuildContext context, GoRouterState state) {
    return const DesktopSplashScreen();
  }
}
