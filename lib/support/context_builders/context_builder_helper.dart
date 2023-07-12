import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import 'context_builder.dart';

extension ContextBuilderHelper<T extends Object> on ContextBuilder<T> {
  @protected
  T getCurrentContextChild(BuildContext context) {
    return _returnChildByPlatform(context) ??
        _returnChildByScreenSize(context) ??
        _getDefaultChild(context);
  }

  T _getDefaultChild(BuildContext context) {
    return ((context.isDesktop || context.isTablet) && wideScreenChild != null)
        ? wideScreenChild!
        : defaultChild!;
  }

  T? _returnChildByPlatform(BuildContext context) {
    switch (context.platform) {
      case TargetPlatform.android:
        if (context.isTablet) {
          return androidTabletChild ?? androidChild;
        } else if (context.isMobile) {
          return androidMobileChild ?? androidChild;
        }
        return androidChild;
      case TargetPlatform.iOS:
        if (context.isTablet) {
          return iosTabletChild ?? iosChild;
        } else if (context.isMobile) {
          return iosMobileChild ?? iosChild;
        }
        return iosChild;
      case TargetPlatform.windows:
        if (context.isMobile) {
          return windowsSmallScreenChild ?? windowsChild;
        }
        if (context.isTablet) {
          return windowsMediumScreenChild ?? windowsChild;
        }
        if (context.isDesktop) {
          return windowsChild;
        }
        break;
      case TargetPlatform.macOS:
        return macOsChild;
      default:
        return null;
    }
    return null;
  }

  T? _returnChildByScreenSize(BuildContext context) {
    switch (context.deviceTypeByScreen) {
      case DeviceType.mobile:
        return mobileScreenChild;
      case DeviceType.tablet:
        return tabletScreenChild;
      case DeviceType.desktop:
        return desktopScreenChild;
      default:
        return null;
    }
  }
}
