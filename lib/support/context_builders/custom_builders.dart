import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

enum BuildingOrder { adaptiveFirst, responsiveFirst }

abstract class _BaseBuilder<T extends Object> {
  final T? fallBackChild;

  const _BaseBuilder({this.fallBackChild});

  T? of(BuildContext context);
}

base class CustomBuilder<T extends Object> extends _BaseBuilder<T> {
  final AdaptiveBuilder<T>? adaptiveBuilder;
  final ResponsiveBuilder<T>? responsiveBuilder;
  final BuildingOrder order;

  const CustomBuilder({
    super.fallBackChild,
    this.responsiveBuilder,
    this.adaptiveBuilder,
    this.order = BuildingOrder.adaptiveFirst,
  }) : assert(fallBackChild != null ||
            adaptiveBuilder != null ||
            responsiveBuilder != null);

  @override
  T of(BuildContext context) {
    return (order == BuildingOrder.adaptiveFirst
            ? adaptiveBuilder?.of(context) ?? responsiveBuilder?.of(context)
            : responsiveBuilder?.of(context) ?? adaptiveBuilder?.of(context)) ??
        fallBackChild!;
  }
}

final class AdaptiveBuilder<T extends Object> extends _BaseBuilder<T> {
  final T? windowsChild;
  final T? androidChild;
  final T? iosChild;
  final T? macOsChild;

  AdaptiveBuilder({
    this.windowsChild,
    this.androidChild,
    this.iosChild,
    this.macOsChild,
    super.fallBackChild,
  }) : assert(
          windowsChild != null ||
              androidChild != null ||
              iosChild != null ||
              macOsChild != null ||
              fallBackChild != null,
        );

  @override
  T? of(BuildContext context) {
    return switch (context.platform) {
          TargetPlatform.android => androidChild,
          TargetPlatform.iOS => iosChild,
          TargetPlatform.windows => windowsChild,
          TargetPlatform.macOS => macOsChild,
          _ => throw UnimplementedError(
              "The platform (${context.platform}) doesn't have an implemented builder",
            ),
        } ??
        fallBackChild;
  }
}

class ResponsiveBuilder<T extends Object> extends _BaseBuilder<T> {
  ResponsiveBuilder({
    this.windowsSmallScreenChild,
    this.windowsMediumScreenChild,
    this.iosMobileChild,
    this.androidMobileChild,
    this.iosTabletChild,
    this.androidTabletChild,
    this.tabletChild,
    this.mobileChild,
    this.wideScreenChild,
    this.desktopChild,
    this.macOsMediumScreenChild,
    this.macOsSmallScreenChild,
    super.fallBackChild,
  }) : assert(
          windowsSmallScreenChild != null ||
              windowsMediumScreenChild != null ||
              iosMobileChild != null ||
              androidMobileChild != null ||
              iosTabletChild != null ||
              androidTabletChild != null ||
              tabletChild != null ||
              mobileChild != null ||
              wideScreenChild != null ||
              macOsMediumScreenChild != null ||
              macOsSmallScreenChild != null ||
              desktopChild != null ||
              fallBackChild != null,
        );

  /// Used If `(context.isWindowsPlatform && context.isMobile)` is true.
  final T? windowsSmallScreenChild;

  /// Used If `(context.isMacOsPlatform && context.isMobile)` is true.
  final T? macOsSmallScreenChild;

  /// Used If `(context.isMacOsPlatform && context.tablet)` is true.
  final T? macOsMediumScreenChild;

  /// Used If `(context.isWindowsPlatform && context.tablet)` is true.
  final T? windowsMediumScreenChild;

  final T? iosMobileChild;

  final T? androidMobileChild;

  final T? iosTabletChild;

  final T? androidTabletChild;

  final T? tabletChild;

  final T? mobileChild;

  final T? desktopChild;

  /// tablet screen or desktop screen
  final T? wideScreenChild;

  @override
  T? of(BuildContext context) {
    print(mobileChild != null);
    return switch (context.deviceTypeByScreen) {
          DeviceType.mobile => switch (context.platform) {
                TargetPlatform.android => androidMobileChild,
                TargetPlatform.iOS => iosMobileChild,
                TargetPlatform.windows => windowsSmallScreenChild,
                TargetPlatform.macOS => macOsSmallScreenChild,
                _ => mobileChild,
              } ??
              mobileChild,
          DeviceType.tablet => switch (context.platform) {
                TargetPlatform.android => androidTabletChild,
                TargetPlatform.iOS => iosTabletChild,
                TargetPlatform.windows => windowsMediumScreenChild,
                _ => tabletChild,
              } ??
              tabletChild ??
              wideScreenChild,
          DeviceType.desktop => desktopChild ?? wideScreenChild,
        } ??
        fallBackChild;
  }
}
