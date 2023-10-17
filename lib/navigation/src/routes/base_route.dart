import 'package:dune/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'page_with_transition_builder.dart';

abstract class BaseQuickNavDestinationRoute extends BaseRoute {
  final QuickNavDestination index;

  BaseQuickNavDestinationRoute({
    required super.path,
    required this.index,
    required super.page,
    super.name,
    super.pageBuilder,
    super.routes,
  });
}

abstract class BaseRoute extends GoRoute {
  BaseRoute({
    super.name,
    List<GoRoute> routes = const [],
    required String path,
    required Widget Function(BuildContext context, GoRouterState state) page,
    PageWithTransitionBuilder pageBuilder =
        const PageWithDrillInTransitionBuilder(),
  }) : super(
          path: path,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return pageBuilder.buildPage(page(context, state), context, state);
          },
          routes: routes,
        );
}
