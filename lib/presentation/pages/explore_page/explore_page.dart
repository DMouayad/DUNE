import 'dart:math';

import 'package:dune/presentation/controllers/explore_music_controller.dart';
import 'package:dune/presentation/custom_widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'package:dune/presentation/custom_widgets/explore_music_collection_widget.dart';
import 'package:dune/domain/audio/base_models/base_explore_music_item.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/domain/audio/base_models/base_explore_music_collection.dart';
import 'package:dune/presentation/custom_widgets/shimmer_widget.dart';
import 'package:dune/presentation/pages/explore_page/trending_header.dart';

const collectionsCountWhenLoading = 1;

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  ExplorePageState createState() => ExplorePageState();
}

class ExplorePageState extends ConsumerState<ExplorePage>
    with AutomaticKeepAliveClientMixin<ExplorePage> {
  /// contains a [ScrollController] for each collection in `collections` list.
  List<ScrollController> _listViewControllers = [];
  late final nestedScrollViewController = ScrollController();

  @override
  void dispose() {
    for (var c in _listViewControllers) {
      c.dispose();
    }
    nestedScrollViewController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive {
    return true;
  }

  /// the items to displayed in the SliverAppBar
  List<BaseExploreMusicItem> trendingItems = [];

  /// explore music collections except trending ones
  List<BaseExploreMusicCollection> collections = [];
  bool isLoading = false;
  bool hasError = false;

  @override
  void initState() {
    final state = ref.read(exploreMusicControllerProvider);
    isLoading = state.isLoading;

    if (state.hasValue) {
      final data = _getDataFromState(state.requireValue);
      collections = data.$1;
      trendingItems = data.$2;
      _listViewControllers =
          List.generate(collections.length, (index) => ScrollController());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(exploreMusicControllerProvider);
    if (state.hasError != hasError) {
      hasError = state.hasError;
      updateKeepAlive();
    }
    if (state.isLoading != isLoading) {
      isLoading = state.isLoading;
      updateKeepAlive();
    }
    if (state.hasValue) {
      final data = _getDataFromState(state.requireValue);
      bool shouldUpdate = false;
      if (collections != data.$1) {
        collections = data.$1;
        _listViewControllers =
            List.generate(collections.length, (index) => ScrollController());
        shouldUpdate = true;
      }
      if (trendingItems != data.$2) {
        trendingItems = data.$2;
        shouldUpdate = true;
      }
      if (shouldUpdate) {
        updateKeepAlive();
      }
    }
    if (hasError && !isLoading) {
      return DuneErrorWidget(
        state.error,
        onRetry: () => ref
            .read(exploreMusicControllerProvider.notifier)
            .loadHomeCollections(
                ref.read(appPreferencesController).exploreMusicSource),
      );
    }
    return Material(
      type: MaterialType.transparency,
      child: NestedScrollView(
        scrollDirection: Axis.vertical,
        controller: nestedScrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: min(290, context.screenHeight * .3),
              collapsedHeight: 30,
              backgroundColor: Colors.transparent,
              toolbarHeight: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ShimmerWidget(
                    enabled: isLoading,
                    childBuilder: () => TrendingHeader(items: trendingItems),
                  ),
                ),
              ),
            ),
          ];
        },
        body: ListView.builder(
          padding: EdgeInsets.only(
              left: context.isMobile ? 8 : 0, top: 30, bottom: 20),
          itemExtent: 340.0,
          scrollDirection: Axis.vertical,
          itemCount:
              isLoading ? collectionsCountWhenLoading : collections.length,
          itemBuilder: (context, index) {
            return ExploreMusicCollectionWidget(
              height: 340,
              collection: isLoading
                  ? const AsyncValue.loading()
                  : AsyncValue.data(collections[index]),
              scrollController: isLoading ? null : _listViewControllers[index],
            );
          },
        ),
      ),
    );
  }

  (List<BaseExploreMusicCollection>, List<BaseExploreMusicItem>)
      _getDataFromState(
    ExploreMusicState state,
  ) {
    List<BaseExploreMusicCollection> collections = [];
    List<BaseExploreMusicItem> trendingItems = [];
    for (BaseExploreMusicCollection collection in state.homeCollections) {
      if (collection.isTrending) {
        trendingItems.addAll(collection.items);
      } else {
        collections.add(collection);
      }
    }
    return (collections, trendingItems);
  }
}
