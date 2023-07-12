import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CardsGridView extends StatelessWidget {
  const CardsGridView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.itemCardWidth,
  });

  final int itemCount;
  final Widget Function(int index) itemBuilder;
  final double itemCardWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimationLimiter(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: itemCardWidth,
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 350),
                columnCount: constraints.maxWidth > 900 ? 4 : 3,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: itemBuilder(index),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
