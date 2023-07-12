export 'context_builder_helper.dart';

class ContextBuilder<T extends Object> {
  /// Used by Default
  final T? defaultChild;

  // Platform Adaptive//
  //
  /// Used If `(context.isWindowsPlatform && context.isMobile)` is true.
  ///
  /// If its `null`, `windowsChild` will be returned
  final T? windowsSmallScreenChild;

  /// Used If `(context.isWindowsPlatform && context.tablet)` is true.
  ///
  /// If its `null`, `windowsChild` will be returned
  final T? windowsMediumScreenChild;

  /// Used If `(context.isWindowsPlatform)` is true
  final T? windowsChild;
  final T? androidChild;
  final T? iosChild;

  final T? macOsChild;

  final T? iosMobileChild;

  final T? androidMobileChild;

  final T? iosTabletChild;

  final T? androidTabletChild;

  final T? tabletScreenChild;

  final T? mobileScreenChild;

  /// tablet screen or desktop screen
  final T? wideScreenChild;

  final T? desktopScreenChild;

  const ContextBuilder({
    this.defaultChild,
    this.windowsChild,
    this.macOsChild,
    this.androidChild,
    this.iosChild,
    this.windowsSmallScreenChild,
    this.windowsMediumScreenChild,
    this.iosMobileChild,
    this.iosTabletChild,
    this.androidMobileChild,
    this.androidTabletChild,
    this.tabletScreenChild,
    this.mobileScreenChild,
    this.wideScreenChild,
    this.desktopScreenChild,
  });

  ContextBuilder<T> copyWith({
    T? defaultChild,
    // by platform
    T? windowsChild,
    T? macOsChild,
    T? androidChild,
    T? iosChild,
    // by platform and screen size
    T? windowsSmallScreenChild,
    T? windowsMediumScreenChild,
    T? iosMobileChild,
    T? androidMobileChild,
    T? iosTabletChild,
    T? androidTabletChild,
    // by screen size
    T? tabletScreenChild,
    T? mobileScreenChild,
    T? wideScreenChild,
    T? desktopScreenChild,
  }) {
    return ContextBuilder(
      defaultChild: defaultChild ?? this.defaultChild,
      iosChild: iosChild ?? this.iosChild,
      androidChild: androidChild ?? this.androidChild,
      windowsSmallScreenChild:
          windowsSmallScreenChild ?? this.windowsSmallScreenChild,
      windowsMediumScreenChild:
          windowsMediumScreenChild ?? this.windowsMediumScreenChild,
      windowsChild: windowsChild ?? this.windowsChild,
      macOsChild: macOsChild ?? this.macOsChild,
      iosMobileChild: iosMobileChild ?? this.iosMobileChild,
      androidMobileChild: androidMobileChild ?? this.androidMobileChild,
      iosTabletChild: iosTabletChild ?? this.iosTabletChild,
      androidTabletChild: androidTabletChild ?? this.androidTabletChild,
      tabletScreenChild: tabletScreenChild ?? this.tabletScreenChild,
      mobileScreenChild: mobileScreenChild ?? this.mobileScreenChild,
      wideScreenChild: wideScreenChild ?? this.wideScreenChild,
      desktopScreenChild: desktopScreenChild ?? this.desktopScreenChild,
    );
  }
}
