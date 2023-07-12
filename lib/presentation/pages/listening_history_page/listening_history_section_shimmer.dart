import 'package:dune/presentation/custom_widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ListeningHistorySectionShimmer extends StatelessWidget {
  const ListeningHistorySectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          flex: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerWidget(
                enabled: true,
                shimmerSize: Size(100, 26),
                borderRadius: 6,
              ),
              ShimmerWidget(
                enabled: true,
                shimmerSize: Size(100, 26),
                borderRadius: 6,
              ),
            ],
          ),
        ),
        AnimationLimiter(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            children: List.generate(
              5,
              (index) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: ShimmerWidget(
                  enabled: true,
                  shimmerSize: Size.fromHeight(44),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
