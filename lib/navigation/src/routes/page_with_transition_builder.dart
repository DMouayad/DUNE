import 'package:dune/presentation/custom_widgets/page_body_wrapper.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

abstract class PageWithTransitionBuilder {
  Page<void> buildPage(
    Widget page,
    BuildContext context,
    GoRouterState state,
  );

  const PageWithTransitionBuilder();
}

class PageWithSlideInTransitionBuilder extends PageWithTransitionBuilder {
  @override
  Page<void> buildPage(
    Widget page,
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage(
      child: PageBodyWrapper(child: page),
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

  const PageWithSlideInTransitionBuilder();
}

class PageWithDrillInTransitionBuilder extends PageWithTransitionBuilder {
  @override
  Page<void> buildPage(
    Widget page,
    BuildContext context,
    GoRouterState state, {
    LocalKey? pageKey,
    Color? barrierColor,
  }) {
    return CustomTransitionPage<void>(
      key: pageKey,
      child: PageBodyWrapper(child: page),
      transitionDuration: const Duration(milliseconds: 350),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return DrillInPageTransition(animation: animation, child: child);
      },
    );
  }

  const PageWithDrillInTransitionBuilder();
}
