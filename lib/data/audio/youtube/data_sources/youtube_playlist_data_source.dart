import 'dart:convert';

import 'package:dune/domain/audio/base_data_sources/base_playlist_data_source.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/support/logger_service.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:http/http.dart' as http;
import '../models/youtube_playlist.dart';

class YoutubePlaylistDataSource extends BasePlaylistDataSource {
  static const String _serverAddress =
      'https://drip-server-fv6tn36q0-spsden.vercel.app/';

  @override
  FutureOrResult<YoutubePlaylist?> find(String playlistId) async {
    const limit = 20;
    return await Result.fromAnother(() async {
      final response = await http.get(Uri.parse(
          '${_serverAddress}searchplaylist?playlistId=$playlistId&limit=$limit'));
      if (response.statusCode == 200) {
        final body = response.body.toString();
        return YoutubePlaylist.fromMap(jsonDecode(body)).asResult;
      } else {
        return FailureResult.withMessage(response.body);
      }
    });
  }

  @override
  FutureOrResult<List<BasePlaylist>> getCategoryPlaylists(
      String categoryId) async {
    Log.i(categoryId);
    return await Result.fromAnother(() async {
      final response = await http
          .get(Uri.parse('${_serverAddress}moodplaylist?params=$categoryId'));
      if (response.statusCode != 200) {
        return FailureResult.withMessage(response.body);
      }
      final data = jsonDecode(response.body);
      final playlists = <YoutubePlaylist>[];
      if (data is Iterable) {
        for (var item in data) {
          if (item is Map<String, dynamic>) {
            playlists.add(YoutubePlaylist.fromMap(item));
          }
        }
      }
      return playlists.asResult;
    });
  }
}
