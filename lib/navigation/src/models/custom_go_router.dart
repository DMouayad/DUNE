import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomGoRouteInformationProvider extends GoRouteInformationProvider {
  CustomGoRouteInformationProvider({
    required super.initialLocation,
    required super.initialExtra,
    super.refreshListenable,
  });

  @override
  void routerReportsNewRouteInformation(RouteInformation routeInformation,
      {RouteInformationReportingType type =
          RouteInformationReportingType.none}) {}

  @override
  Future<bool> didPushRouteInformation(
          RouteInformation routeInformation) async =>
      true;

  @override
  Future<bool> didPushRoute(String route) async => true;
}

class CustomGoRouter extends GoRouter {
  CustomGoRouter({
    required super.routes,
    super.onException,
    super.errorPageBuilder,
    super.errorBuilder,
    super.redirect,
    this.refreshListenable,
    super.redirectLimit = 5,
    super.routerNeglect = false,
    this.initialLocation,
    this.initialExtra,
    super.observers,
    super.debugLogDiagnostics = false,
    super.navigatorKey,
    super.restorationScopeId,
  }) : super(
          initialLocation: initialLocation,
          initialExtra: initialExtra,
          refreshListenable: refreshListenable,
        );

  final String? initialLocation;
  final Object? initialExtra;
  final Listenable? refreshListenable;

  late final GoRouteInformationProvider _routeInformationProvider =
      CustomGoRouteInformationProvider(
    initialLocation: initialLocation ?? '/',
    initialExtra: initialExtra,
    refreshListenable: refreshListenable,
  );

  @override
  set routeInformationProvider(RouteInformationProvider value) {}

  @override
  GoRouteInformationProvider get routeInformationProvider =>
      _routeInformationProvider;
}
