import 'package:dune/presentation/custom_widgets/dune_loading_widget.dart';
import 'package:dune/presentation/pages/search_page/search_result_widgets/artists_result_widget.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/models/search_state.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/utils/error/app_error.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../custom_widgets/tracks_list_view.dart';
import 'albums_result_widget.dart';
import 'playlists_result_widget.dart';

class SearchResultsWidget extends ConsumerWidget {
  const SearchResultsWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final searchState = ref.watch(searchControllerProvider);
    final searchFilter = searchState.valueOrNull?.filter ?? SearchFilter.all;
    final AppError? stateError =
        searchState.error is AppError ? searchState.error as AppError : null;
    return Theme(
      data: ref.watch(appThemeControllerProvider).materialThemeData,
      child: ScrollConfiguration(
        behavior: const fluent_ui.FluentScrollBehavior(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          dragStartBehavior: DragStartBehavior.down,
          physics: const BouncingScrollPhysics(
            parent: ClampingScrollPhysics(),
          ),
          clipBehavior: Clip.hardEdge,
          primary: true,
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              childAnimationBuilder: (widget) {
                return SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(child: widget),
                );
              },
              children: [
                if (searchFilter.hasSongs)
                  _SearchResultCategorySection(
                    isLoading: searchState.isLoading,
                    category: SearchFilter.songs,
                    title: "Songs",
                    error: stateError,
                    isLoadingMoreForCategory: searchState
                        .valueOrNull?.loadingMoreOf
                        .contains(SearchFilter.songs),
                    content: TracksListView(
                      searchState.isLoading &&
                              searchState
                                  .requireValue.songsSearchResult.data.isEmpty
                          ? const AsyncValue.loading()
                          : AsyncValue.data(
                              searchState.requireValue.songsSearchResult.data,
                            ),
                    ),
                  ),
                if (searchFilter.hasArtists)
                  _SearchResultCategorySection(
                    isLoading: searchState.isLoading,
                    category: SearchFilter.artists,
                    isLoadingMoreForCategory: searchState
                        .valueOrNull?.loadingMoreOf
                        .contains(SearchFilter.artists),
                    title: "Artists",
                    error: stateError,
                    content: ArtistsSearchResults(
                      searchState.isLoading &&
                              searchState
                                  .requireValue.artistsSearchResult.data.isEmpty
                          ? const AsyncValue.loading()
                          : AsyncValue.data(
                              searchState.requireValue.artistsSearchResult.data,
                            ),
                    ),
                  ),
                if (searchFilter.hasAlbums)
                  _SearchResultCategorySection(
                    isLoading: searchState.isLoading,
                    category: SearchFilter.albums,
                    error: stateError,
                    isLoadingMoreForCategory: searchState
                        .valueOrNull?.loadingMoreOf
                        .contains(SearchFilter.albums),
                    title: "Albums",
                    content: AlbumsResultWidget(
                      searchState.isLoading &&
                              searchState
                                  .requireValue.albumsSearchResult.data.isEmpty
                          ? const AsyncValue.loading()
                          : AsyncValue.data(
                              searchState.requireValue.albumsSearchResult.data,
                            ),
                    ),
                  ),
                if (searchFilter.hasPlaylists)
                  _SearchResultCategorySection(
                    isLoading: searchState.isLoading,
                    category: SearchFilter.playlists,
                    isLoadingMoreForCategory: searchState
                        .valueOrNull?.loadingMoreOf
                        .contains(SearchFilter.playlists),
                    title: "Community Playlists",
                    error: stateError,
                    content: PlaylistsResultWidget(
                      searchState.isLoading &&
                              searchState.requireValue.playlistsSearchResult
                                  .data.isEmpty
                          ? const AsyncValue.loading()
                          : AsyncValue.data(
                              searchState
                                  .requireValue.playlistsSearchResult.data,
                            ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchResultCategorySection extends ConsumerWidget {
  const _SearchResultCategorySection({
    required this.title,
    required this.content,
    required this.isLoading,
    required this.category,
    required this.isLoadingMoreForCategory,
    this.error,
  });

  final String title;
  final Widget content;
  final bool isLoading;
  final SearchFilter category;
  final bool? isLoadingMoreForCategory;
  final AppError? error;

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: context.colorScheme.primary,
              ),
            ),
            Expanded(flex: 0, child: content),
            if (!isLoading &&
                !(isLoadingMoreForCategory ?? false) &&
                error == null)
              Center(
                child: TextButton(
                  onPressed: () {
                    ref
                        .read(searchControllerProvider.notifier)
                        .getMoreResultsFor(
                          category,
                          ref.watch(appPreferencesController).searchEngine,
                        );
                  },
                  child: Text(
                    "load more...",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            if (error != null)
              ListTile(
                tileColor: context.colorScheme.errorContainer,
                leading: Icon(Icons.error, color: context.colorScheme.error),
                title: Text(
                  error!.appException?.message ??
                      error!.description ??
                      "Failed to load ${category.name}",
                ),
              ),
            if (isLoadingMoreForCategory ?? false)
              const Center(child: DuneLoadingWidget(size: 24)),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
