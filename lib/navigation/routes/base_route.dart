import 'package:dune/navigation/app_router.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

import 'page_with_transition_builder.dart';

abstract class BaseQuickNavDestinationRoute extends BaseRoute {
  final QuickNavDestination index;

  BaseQuickNavDestinationRoute({
    required super.path,
    required this.index,
    required super.page,
    super.isSubRoute,
    super.name,
    super.pageBuilder,
    super.routes,
  });
}

abstract class BaseRoute extends GoRoute {
  BaseRoute({
    super.name,
    bool isSubRoute = false,
    List<GoRoute> routes = const [],
    required String path,
    required Widget Function(BuildContext context, GoRouterState state) page,
    PageWithTransitionBuilder pageBuilder =
        const PageWithDrillInTransitionBuilder(),
  }) : super(
          path: isSubRoute ? path.replaceFirst('/', '') : path,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return pageBuilder.buildPage(page(context, state), context, state);
          },
          routes: routes,
        );
}
