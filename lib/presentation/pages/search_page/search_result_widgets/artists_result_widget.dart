import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/presentation/custom_widgets/shimmer_widget.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'search_result_items_grid.dart';
import '../../../custom_widgets/custom_card.dart';

const maxCardHeight = 180.0;

class ArtistsSearchResults extends ConsumerWidget {
  const ArtistsSearchResults(this.results, {Key? key}) : super(key: key);
  final AsyncValue<List<BaseArtist>> results;

  @override
  Widget build(BuildContext context, ref) {
    return SearchResultItemsGrid(
      maxHeight: maxCardHeight,
      itemsCount: results.isLoading ? 4 : results.valueOrNull?.length ?? 0,
      childBuilder: (index) {
        return results.when(
          error: (err, stack) => Text('error $err'),
          loading: () => const _ArtistsShimmer(),
          data: (artists) {
            final artist = artists.elementAt(index);
            return CustomCard(
              width: maxCardHeight,
              tag: artist.id ?? artist.browseId ?? artist.hashCode.toString(),
              title: artist.name,
              thumbnails: artist.thumbnails,
              shape: BoxShape.circle,
              onTap: () {},
            );
          },
        );
      },
    );
  }
}

class _ArtistsShimmer extends StatelessWidget {
  const _ArtistsShimmer();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: ShimmerWidget(
            enabled: true,
            shimmerSize: Size.fromHeight(maxCardHeight - 30),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(height: 4),
        Expanded(
          flex: 0,
          child: ShimmerWidget(
            enabled: true,
            shimmerSize: Size.fromHeight(20),
            borderRadius: 12,
          ),
        ),
      ],
    );
  }
}
