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
    this.direction = const ShimmerDirection.fromLeftToRight(),
    required this.enabled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final child = Shimmer(
      direction: direction,
      duration: const Duration(milliseconds: 1500),
      color: context.colorScheme.primaryContainer,
      colorOpacity: .6,
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
            child: child,
          )
        : ClipOval(child: child);
  }
}
