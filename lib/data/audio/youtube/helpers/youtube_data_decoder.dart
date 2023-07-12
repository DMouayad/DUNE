import 'package:dune/support/extensions/extensions.dart';

mixin YoutubeAudioDecodingHelper {
  static List<Map<String, dynamic>> formatItems(List itemsList) {
    final result = itemsList.map((e) {
      final dataMap = (e as Map).valueOfAnyKey([
        'compactStationRenderer',
        'gridPlaylistRenderer',
        'gridVideoRenderer'
      ]) as Map<String, dynamic>;
      final thumbnails = dataMap.whereKey('thumbnail')?['thumbnails'] as List?;
      final length = dataMap.whereKey('thumbnailOverlays')?[0]
          ?['thumbnailOverlayTimeStatusRenderer']?['text']?['simpleText'];
      final duration = _getDurationInSeconds(length)?.toString() ?? '0';
      return {
        'title': dataMap.whereKey('title')?['simpleText'] ??
            dataMap.whereKey('title')?['runs']?[0]?['text'] ??
            '',
        'type': dataMap.whereKey('navigationEndpoint')?['watchEndpoint']
                    ?['playlistId'] !=
                null
            ? 'playlist'
            : 'video',
        'description': dataMap.whereKey('description')?['simpleText'] ??
            dataMap.whereKey('shortBylineText')?['runs']?[0]?['text'] ??
            '',
        'count': dataMap.whereKey('videoCountText')?['runs']?[0]?['text'] ??
            dataMap.whereKey('shortViewCountText')?['simpleText'] ??
            '',
        'durationInSeconds': duration,
        'sourceId': dataMap.whereKey('navigationEndpoint')?['watchEndpoint']
                ?['playlistId'] ??
            dataMap.whereKey('navigationEndpoint')?['watchEndpoint']
                ?['videoId'] ??
            dataMap.whereKey('videoId') ??
            '',
        'firstItemId': dataMap.whereKey('navigationEndpoint')?['watchEndpoint']
                ?['playlistId'] ??
            dataMap.whereKey('videoId') ??
            '',
        if (thumbnails?.isNotEmpty ?? false)
          'imageStandard': thumbnails?[0]?['url'],
        if (thumbnails != null && thumbnails.length >= 2)
          'imageMedium': thumbnails[1]?['url'],
        if (thumbnails != null && thumbnails.length >= 3)
          'imageMax': thumbnails[2]?['url'],
      };
    }).toList();

    return result;
  }

  static List<Map<String, dynamic>> formatHeadItems(List itemsList) {
    final result = itemsList.map((e) {
      final length = e['defaultPromoPanelRenderer']['inlinePlaybackRenderer']
          ?['inlinePlaybackRenderer']?['lengthText']?['simpleText'];
      final duration = _getDurationInSeconds(length)?.toString() ?? '0';
      return {
        'title': e['defaultPromoPanelRenderer']['title']['runs'][0]['text'],
        'type': 'video',
        'description':
            (e['defaultPromoPanelRenderer']['description']['runs'] as List)
                .map((e) => e['text'])
                .toList()
                .join(),
        'sourceId': e['defaultPromoPanelRenderer']['navigationEndpoint']
            ['watchEndpoint']['videoId'],
        'firstItemId': e['defaultPromoPanelRenderer']['navigationEndpoint']
            ['watchEndpoint']['videoId'],
        'durationInSeconds': duration,
        'image': e['defaultPromoPanelRenderer']
                        ['largeFormFactorBackgroundThumbnail']
                    ['thumbnailLandscapePortraitRenderer']['landscape']
                ['thumbnails']
            .last['url'],
        'imageMedium': e['defaultPromoPanelRenderer']
                    ['largeFormFactorBackgroundThumbnail']
                ['thumbnailLandscapePortraitRenderer']['landscape']
            ['thumbnails'][1]['url'],
        'imageStandard': e['defaultPromoPanelRenderer']
                    ['largeFormFactorBackgroundThumbnail']
                ['thumbnailLandscapePortraitRenderer']['landscape']
            ['thumbnails'][2]['url'],
        'imageMax': e['defaultPromoPanelRenderer']
                        ['largeFormFactorBackgroundThumbnail']
                    ['thumbnailLandscapePortraitRenderer']['landscape']
                ['thumbnails']
            .last['url'],
      };
    }).toList();

    return result;
  }

  static int? _getDurationInSeconds(String? length) {
    try {
      if (length == null) return null;
      final digits = length.split(':');
      return (int.parse(digits[0]) * 60) + int.parse(digits[1]);
    } catch (e) {
      return null;
    }
  }
}
