import 'dart:math';

import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'shimmer_widget.dart';

class ScrollableCardsView extends StatelessWidget {
  const ScrollableCardsView({
    required this.scrollController,
    required this.childBuilder,
    required this.itemsState,
    this.itemWidth,
    this.height,
    this.titleWidget,
    this.displayAsGrid = false,
    super.key,
  });

  final ScrollController? scrollController;
  final Widget Function(double cardWidth, int index) childBuilder;
  final double? height;
  final double? itemWidth;
  final bool displayAsGrid;
  final AsyncValue<({int itemCount, String? title})> itemsState;
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    final isLoading = itemsState.isLoading;

    final itemCardWidth = itemWidth ??
        min(220.0, context.screenWidth * (context.screenWidth < 750 ? .5 : .3));
    return Stack(
      children: [
        Column(
          children: [
            _Title(
              isLoading,
              titleText: itemsState.valueOrNull?.title,
              title: titleWidget,
            ),
            if (displayAsGrid)
              Expanded(
                flex: 0,
                child: SizedBox(
                  height: height ?? itemCardWidth,
                  // width: double.infinity,
                  child: GridView.builder(
                    // shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: itemCardWidth,
                      crossAxisSpacing: (height ?? 0) > itemCardWidth ? 8 : 0,
                    ),
                    controller: scrollController,
                    physics: context.isDesktopPlatform
                        ? const NeverScrollableScrollPhysics()
                        : null,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    itemCount:
                        isLoading ? 4 : itemsState.requireValue.itemCount,
                    itemBuilder: (context, index) {
                      return _itemBuilder(
                        index,
                        isLoading,
                        itemCardWidth,
                        showDuration: const Duration(milliseconds: 200),
                        delayDuration: const Duration(milliseconds: 80),
                      );
                    },
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemExtent: itemCardWidth,
                  controller: scrollController,
                  physics: context.isDesktopPlatform
                      ? const NeverScrollableScrollPhysics()
                      : null,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: isLoading ? 5 : itemsState.requireValue.itemCount,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8),
                      child: _itemBuilder(index, isLoading, itemCardWidth),
                    );
                  },
                ),
              ),
            const SizedBox(height: 30),
          ],
        ),
        if (!isLoading)
          Positioned.fill(
            top: 5,
            right: 14,
            child: Align(
              alignment: Alignment.topRight,
              child: _NavArrows(
                onNext: () {
                  // first calculate the number of visible cards
                  final currentDisplayedItemsCount =
                      (scrollController!.position.viewportDimension /
                              itemCardWidth)
                          .floor();
                  // change the scrollController position to be after the position
                  // of all visible cards which is equal to:
                  // (itemCardWidth * currentDisplayedItemsCount)
                  scrollController!.animateTo(
                    scrollController!.position.pixels +
                        (itemCardWidth * currentDisplayedItemsCount),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
                onPrevious: () {
                  final currentDisplayedItemCount =
                      (scrollController!.position.viewportDimension /
                              itemCardWidth)
                          .floor();
                  scrollController!.animateTo(
                    scrollController!.position.pixels -
                        (itemCardWidth * currentDisplayedItemCount),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
              ),
            ),
          )
      ],
    );
  }

  Widget _itemBuilder(
    int index,
    bool isLoading,
    double itemCardWidth, {
    Duration? showDuration,
    Duration? delayDuration,
  }) {
    return ShimmerWidget(
      enabled: isLoading,
      shimmerSize: Size.fromWidth(itemCardWidth),
      borderRadius: 10,
      childBuilder: () {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: showDuration ?? const Duration(milliseconds: 375),
          delay: delayDuration ?? const Duration(milliseconds: 200),
          child: SlideAnimation(
            verticalOffset: displayAsGrid ? 50.0 : 0.0,
            horizontalOffset: displayAsGrid ? 0.0 : -40,
            child: FadeInAnimation(
              child: childBuilder(itemCardWidth, index),
            ),
          ),
        );
      },
    );
  }
}

class _Title extends StatelessWidget {
  final bool isLoading;
  final String? titleText;
  final Widget? title;

  const _Title(this.isLoading, {this.title, this.titleText});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      enabled: isLoading,
      // Placing the [Text] widget inside a [Row] to align it to the start
      childBuilder: () => Row(
        children: [
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(7, 7, 0, 5),
              child: title ??
                  Text(
                    titleText ?? '',
                    style: context.textTheme.titleLarge,
                    textAlign: TextAlign.left,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavArrows extends StatelessWidget {
  final void Function() onPrevious;
  final void Function() onNext;

  const _NavArrows({
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: onPrevious,
          icon: Icon(
            Icons.navigate_before_rounded,
            size: 24.0,
            color: context.colorScheme.onSecondaryContainer,
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: onNext,
          icon: Icon(
            Icons.navigate_next_rounded,
            size: 24.0,
            color: context.colorScheme.onSecondaryContainer,
          ),
        ),
      ],
    );
  }
}
