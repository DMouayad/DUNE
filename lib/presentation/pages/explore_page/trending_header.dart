import 'dart:async';
import 'dart:math';

import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/domain/audio/base_models/base_explore_music_item.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrendingHeader extends ConsumerStatefulWidget {
  final List<BaseExploreMusicItem> items;

  const TrendingHeader({Key? key, required this.items}) : super(key: key);

  @override
  ConsumerState<TrendingHeader> createState() => _TrendingHeaderState();
}

class _TrendingHeaderState extends ConsumerState<TrendingHeader> {
  int _currentPage = 0;
  late final Timer _timer;
  late final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final imageProvider = ExtendedNetworkImageProvider(
          widget.items[index].thumbnails!
              .byOrder(ThumbnailQualitiesOrderOption.best, true)
              .url,
          cache: true,
          retries: 2,
        );
        return InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            if (widget.items[index].track != null) {
              ref
                  .read(playbackControllerProvider.notifier)
                  .player
                  .playSingleTrack(widget.items[index].track!);
            }
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                left: 20,
                bottom: 20,
                child: SizedBox(
                  width: context.screenWidth * .3,
                  child: Text(
                    widget.items[index].title,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Opacity(
                opacity: .3,
                child: Container(
                  constraints: const BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  constraints: BoxConstraints.loose(
                    Size.fromWidth(min(320, context.screenWidth * .4)),
                  ),
                  margin: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
