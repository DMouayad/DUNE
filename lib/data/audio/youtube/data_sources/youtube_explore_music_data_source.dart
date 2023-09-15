import 'dart:convert';

import 'package:dune/data/audio/youtube/helpers/youtube_data_decoder.dart';
import 'package:dune/data/audio/youtube/models/youtube_explore_music_collection.dart';
import 'package:dune/data/audio/youtube/models/youtube_explore_music_item.dart';
import 'package:dune/domain/audio/base_data_sources/base_explore_music_data_source.dart';
import 'package:dune/domain/audio/base_models/base_explore_music_item.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:http/http.dart' as http;

const Map paths = {
  'search': '/results',
  'channel': '/channel',
  'music': '/music',
  'playlist': '/playlist'
};
const ytUrl = 'www.youtube.com';

class YoutubeExploreMusicDataSource
    extends BaseExploreMusicDataSource<YoutubeExploreMusicCollection> {
  const YoutubeExploreMusicDataSource();

  static const String _serverAddress =
      'https://drip-server-fv6tn36q0-spsden.vercel.app/';

  @override
  FutureOrResult<List<YoutubeExploreMusicCollection>> getMainItems() async {
    return await Result.fromAnother(() async {
      final Uri link = Uri.https(
        ytUrl,
        paths['music'].toString(),
      );
      final response = await http.get(link);
      if (response.statusCode != 200) {
        return FailureResult(AppError(message: response.body));
      }

      final String searchResults =
          RegExp(r'(\"contents\":{.*?}),\"metadata\"', dotAll: true)
              .firstMatch(response.body)![1]!;
      final Map data = json.decode('{$searchResults}') as Map;

      final List result = data['contents']['twoColumnBrowseResultsRenderer']
              ['tabs'][0]['tabRenderer']['content']['sectionListRenderer']
          ['contents'] as List;

      final List headResult = data['header']['carouselHeaderRenderer']
          ['contents'][0]['carouselItemRenderer']['carouselItems'] as List;

      final List shelfRenderer = result.map((element) {
        return element['itemSectionRenderer']['contents'][0]['shelfRenderer'];
      }).toList();

      final finalResult = shelfRenderer.map((element) {
        return {
          'title': element['title']['runs'][0]['text'],
          'items': YoutubeAudioDecodingHelper.formatItems(
              element['content']['horizontalListRenderer']['items'] as List),
        };
      }).toList();
      final finalHeadResult =
          YoutubeAudioDecodingHelper.formatHeadItems(headResult).map((e) {
        e.addAll({'isTrending': true});
        return e;
      }).toList();

      final trendingItems = finalHeadResult
          .map((e) => YoutubeExploreMusicItem.fromApiResponseMap(e))
          .toList();

      return [
        YoutubeExploreMusicCollection(
          isTrending: true,
          title: 'Trending Board',
          items: trendingItems,
        ),
        ...finalResult
            .map((e) => YoutubeExploreMusicCollection.fromMap(e))
            .toList(),
      ].asResult;
    });
  }

  @override
  FutureOrResult<List<YoutubeExploreMusicCollection>>
      getExploreMusicItemsByMoodsAndGenres() async {
    return await Result.fromAnother(() async {
      final response = await http.get(Uri.parse('${_serverAddress}moodcat'));
      if (response.statusCode != 200) {
        return FailureResult.withMessage(response.body);
      }
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      final moodsCollection = data.whereKey("Moods & moments");
      final genresCollection = data.whereKey("Genres");
      return [
        if (moodsCollection is Iterable)
          YoutubeExploreMusicCollection(
            isTrending: false,
            title: "What's your mood?",
            items: moodsCollection
                .map((e) => YoutubeExploreMusicItem(
                      type: ExploreMusicItemType.playlist,
                      title: e['title'] ?? 'Not found',
                      sourceId: e['params'] ?? 'Not found',
                    ))
                .toList(),
          ),
        if (genresCollection is Iterable)
          YoutubeExploreMusicCollection(
            isTrending: false,
            title: 'Explore By Genre',
            items: genresCollection
                .map((e) => YoutubeExploreMusicItem(
                      type: ExploreMusicItemType.playlist,
                      title: e['title'] ?? 'Not found',
                      sourceId: e['params'] ?? 'Not found',
                    ))
                .toList(),
          ),
      ].asResult;
    });
  }
}
