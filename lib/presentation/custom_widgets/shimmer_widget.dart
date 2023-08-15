import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
export 'package:shimmer_animation/shimmer_animation.dart' show ShimmerDirection;

class ShimmerWidget extends StatelessWidget {
  final Widget Function()? childBuilder;
  final bool enabled;
  final Size? shimmerSize;
  final double borderRadius;
  final BoxShape shape;
  final ShimmerDirection direction;

  const ShimmerWidget({
    this.childBuilder,
    this.borderRadius = 10,
    this.shimmerSize,
    this.shape = BoxShape.rectangle,
    this.direction = const ShimmerDirection.fromLTRB(),
    required this.enabled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final child = Shimmer(
      interval: const Duration(milliseconds: 600),
      direction: direction,
      duration: const Duration(milliseconds: 2000),
      color: context.colorScheme.primaryContainer,
      colorOpacity: .7,
      enabled: enabled,
      child: enabled
          ? shimmerSize != null
              ? SizedBox.fromSize(size: shimmerSize!)
              : const SizedBox.shrink()
          : childBuilder != null
              ? childBuilder!()
              : const SizedBox.shrink(),
    );
    return shape == BoxShape.rectangle
        ? ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: enabled
                ? Container(
                    color: context.colorScheme.onBackground.withOpacity(.05),
                    child: child,
                  )
                : child,
          )
        : ClipOval(
            child: enabled
                ? Container(
                    color: context.colorScheme.onBackground.withOpacity(.05),
                    child: child,
                  )
                : child,
          );
  }
}
