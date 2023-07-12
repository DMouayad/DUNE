import 'package:dune/presentation/utils/navigation_helper.dart';
import 'package:flutter/material.dart';

//
import 'package:extended_image/extended_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

//
import 'package:dune/domain/audio/base_models/base_explore_music_item.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/presentation/providers/state_controllers.dart';

import 'image_place_holder.dart';

class ExploreMusicItemCard extends ConsumerWidget {
  final BaseExploreMusicItem item;
  final double itemBoxWidth;

  const ExploreMusicItemCard({
    super.key,
    required this.item,
    required this.itemBoxWidth,
  });

  @override
  Widget build(BuildContext context, ref) {
    final cardBorderRadius = BorderRadius.circular(10.0);
    final url = item.thumbnails!
        .byOrder(ref.watch(appPreferencesController).thumbnailQualitiesOrder)
        .url;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        borderRadius: cardBorderRadius,
        onTap: () {
          if (item.type.isVideo) {
            if (item.track != null) {
              ref
                  .read(playbackControllerProvider.notifier)
                  .player
                  .playSingleTrack(item.track!);
            }
          } else {
            NavigationHelper.onPlaylistItemCardPressed(
              context,
              ref,
              exploreItem: item,
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: context.colorScheme.surfaceVariant.withOpacity(.7),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6),
          width: itemBoxWidth,
          height: itemBoxWidth + 10,
          child: Column(
            children: [
              Expanded(
                child: Hero(
                  tag: item.title,
                  child: Card(
                    margin: const EdgeInsets.only(top: 15.0),
                    elevation: 5,
                    shape:
                        RoundedRectangleBorder(borderRadius: cardBorderRadius),
                    clipBehavior: Clip.antiAlias,
                    child: item.thumbnails != null
                        ? ExtendedImage.network(
                            url,
                            fit: fluent.BoxFit.cover,
                            cache: true,
                            clearMemoryCacheIfFailed: true,
                          )
                        : const FittedBox(child: ImagePlaceHolder()),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Text(
                item.title,
                textAlign: TextAlign.left,
                softWrap: false,
                style: const fluent.TextStyle(fontWeight: FontWeight.w700),
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15, left: 5, right: 5),
                child: Text(
                  item.type.isVideo
                      ? '${item.count} | ${item.description}'
                      : '${item.count} Tracks | ${item.description}',
                  textAlign: TextAlign.center,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
