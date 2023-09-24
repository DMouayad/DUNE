import 'package:flutter/material.dart';

//
import 'package:dune/domain/audio/base_models/thumbnails_set.dart';
import 'package:dune/presentation/controllers/selection_controller.dart';
import 'package:dune/presentation/custom_widgets/dune_loading_widget.dart';
import 'package:dune/presentation/custom_widgets/placeholders.dart';
import 'package:dune/presentation/custom_widgets/selection_tool_bar.dart';
import 'package:dune/presentation/custom_widgets/thumbnail_with_gestures_widget.dart';
import 'package:dune/support/extensions/context_extensions.dart';

class PersistentPageHeaderDelegate<T extends Object>
    extends SliverPersistentHeaderDelegate {
  final double minHeaderExtent;
  final double maxHeaderExtent;
  final String? description;
  final String title;
  final ThumbnailsSet? thumbnailsSet;
  final int? itemsCount;
  final void Function()? onShuffle;
  final bool isFetchingItems;
  final SelectionController<T> selectionController;
  final SelectionState<T> selectionState;
  final void Function() onSelectAll;
  final void Function()? onDownload;
  final void Function()? onRemove;

  PersistentPageHeaderDelegate({
    required this.minHeaderExtent,
    required this.maxHeaderExtent,
    required this.title,
    required this.selectionController,
    required this.selectionState,
    required this.onSelectAll,
    this.description,
    this.onShuffle,
    this.thumbnailsSet,
    this.itemsCount,
    this.isFetchingItems = false,
    this.onDownload,
    this.onRemove,
  });

  static const selectionToolbarMinExtent = 60.0;
  static const selectionToolbarMaxExtent = 100.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    /// the height of [_Header] without including the [SelectionToolBar]
    /// height
    final pageHeaderHeight = maxExtent -
        shrinkOffset -
        (selectionState.selectionEnabled ? selectionToolbarMaxExtent : 0);
    final isMinimized = pageHeaderHeight < minHeaderExtent;

    /// whether this persistent header is fully expanded
    final isExpanded = shrinkOffset == 0;
    final selectionToolbarExtent =
        isExpanded ? selectionToolbarMaxExtent : selectionToolbarMinExtent;
    return Column(
      children: [
        Expanded(
          flex: 0,
          child: _Header(
            height: isMinimized
                ? minExtent -
                    (selectionState.selectionEnabled
                        ? selectionToolbarMinExtent
                        : 0)
                : pageHeaderHeight,
            isMinimized: isMinimized,
            description: description,
            title: title,
            onShuffle: onShuffle,
            thumbnailsSet: thumbnailsSet,
            itemsCount: itemsCount,
            isFetchingItems: isFetchingItems,
          ),
        ),
        if (selectionState.selectionEnabled)
          Expanded(
            flex: 0,
            child: SizedBox(
              height: selectionToolbarExtent,
              child: SelectionToolBar(
                controller: selectionController,
                selectionState: selectionState,
                onSelectAll: onSelectAll,
                isExpanded: isExpanded,
                onDownload: onDownload,
                onRemove: onRemove,
              ),
            ),
          ),
      ],
    );
  }

  @override
  double get maxExtent =>
      maxHeaderExtent +
      (selectionState.selectionEnabled ? selectionToolbarMaxExtent : 0);

  @override
  double get minExtent =>
      minHeaderExtent +
      (selectionState.selectionEnabled ? selectionToolbarMinExtent : 0);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class _Header extends StatelessWidget {
  final String? description;
  final String title;
  final ThumbnailsSet? thumbnailsSet;
  final int? itemsCount;
  final void Function()? onShuffle;
  final bool isFetchingItems;
  final double height;
  final bool isMinimized;

  const _Header({
    required this.height,
    required this.isMinimized,
    required this.description,
    required this.title,
    required this.onShuffle,
    required this.thumbnailsSet,
    required this.itemsCount,
    required this.isFetchingItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        border: Border(
          bottom: BorderSide(
            width: 3,
            color: context.colorScheme.secondary.withOpacity(.15),
          ),
        ),
      ),
      constraints: BoxConstraints.expand(
        height: height,
        width: double.infinity,
      ),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (thumbnailsSet != null)
            Hero(
              tag: title,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 18),
                child: ThumbnailWithGesturesWidget(
                  cacheImage: true,
                  constraints: BoxConstraints.loose(Size.square(height * .9)),
                  thumbnailsSet: thumbnailsSet,
                  placeholder: const PlaylistCoverPlaceholder(),
                ),
              ),
            ),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 16,
                  left: 10,
                  bottom: 0,
                  child: Text(
                    title,
                    softWrap: true,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
                if (description != null)
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 150),
                    bottom: isMinimized ? 6 : height * .3,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      width: 330,
                      child: Text(
                        description!,
                        maxLines: 3,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 150),
                  bottom: height * .1,
                  top: isMinimized ? 0 : null,
                  right: isMinimized ? 10 : null,
                  left: isMinimized ? null : 0,
                  child: TextButton.icon(
                    onPressed: onShuffle,
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                          context.colorScheme.secondary),
                    ),
                    icon: const Icon(Icons.shuffle, size: 20),
                    label: Text("shuffle (${itemsCount ?? 0} items)"),
                  ),
                ),
                if (isFetchingItems)
                  Positioned(
                    top: 0,
                    right: 6,
                    child: DuneLoadingWidget(size: isMinimized ? 14 : 24),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
