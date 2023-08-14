part of app_router;

class DesktopSplashScreenRoute extends GoRoute {
  DesktopSplashScreenRoute()
      : super(
          path: RoutePath.desktopSplashScreenPage,
          builder: _build,
          redirect: (context, state) async {
            if (context.isDesktopPlatform) {
              return null;
            } else {
              return AppRouter.initialAppPage.path;
            }
          },
        );

  static Widget _build(BuildContext context, GoRouterState state) {
    return const DesktopSplashScreen();
  }
}
