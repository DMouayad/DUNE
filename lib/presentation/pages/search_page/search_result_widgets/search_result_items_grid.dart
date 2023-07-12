import 'package:flutter/material.dart';

class SearchResultItemsGrid extends StatelessWidget {
  const SearchResultItemsGrid({
    super.key,
    required this.maxHeight,
    required this.itemsCount,
    required this.childBuilder,
  });

  final double maxHeight;
  final int itemsCount;
  final Widget Function(int index) childBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 18),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: maxHeight,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 10.0,
        // childAspectRatio: 1 / 1.5,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) => childBuilder(index),
        childCount: itemsCount,
      ),
    );
  }
}
