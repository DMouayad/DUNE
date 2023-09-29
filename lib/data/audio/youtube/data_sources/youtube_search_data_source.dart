import 'dart:convert';

import 'package:dune/data/audio/youtube/models/youtube_album.dart';
import 'package:dune/data/audio/youtube/models/youtube_artist.dart';
import 'package:dune/data/audio/youtube/models/youtube_playlist.dart';
import 'package:dune/data/audio/youtube/models/youtube_track.dart';
import 'package:dune/domain/audio/base_data_sources/base_search_data_source.dart';
import 'package:dune/domain/audio/base_models/base_album.dart';
import 'package:dune/domain/audio/base_models/base_artist.dart';
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/domain/audio/base_models/base_playlist.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:http/http.dart' as http;

class YoutubeSearchDataSource extends BaseSearchDataSource {
  const YoutubeSearchDataSource();

  static const String serverAddress =
      'https://drip-server-fv6tn36q0-spsden.vercel.app/';

  @override
  FutureOrResult<List<SearchSuggestion>> getSearchSuggestionsFor(
      String term) async {
    return await Result.fromAnother(() async {
      const searchUrl =
          'https://suggestqueries-clients6.youtube.com/complete/search?client=firefox&q=';
      final Uri link = Uri.parse(searchUrl + term);

      const headers = {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; rv:96.0) Gecko/20100101 Firefox/96.0'
      };

      final response = await http.get(link, headers: headers);

      if (response.statusCode == 200) {
        // print(response.body);
        final List searchSuggestion = jsonDecode(response.body);
        final List listOfSuggestions = searchSuggestion[1];

        return listOfSuggestions
            .map((e) => SearchSuggestion(title: e.toString()))
            .toList()
            .asResult;
      } else {
        return FailureResult.withMessage(response.body);
      }
    });
  }

  @override
  FutureOrResult<List<BaseAlbum>> searchAlbums(String term, int page) async {
    return await Result.fromAnother(() async {
      final response = await http.get(Uri.parse(
          '${serverAddress}searchwithfilter?query=$term&filter=albums&pageNum=$page'));
      if (response.statusCode != 200) {
        return FailureResult.withMessage(response.body);
      }
      final results = jsonDecode(response.body) as List;
      return results.map((e) => YoutubeAlbum.fromMap(e)).toList().asResult;
    });
  }

  @override
  FutureOrResult<List<BaseArtist>> searchArtists(String term, int page) async {
    return await Result.fromAnother(() async {
      final response = await http.get(Uri.parse(
          '${serverAddress}searchwithfilter?query=$term&filter=artists&pageNum=$page'));
      if (response.statusCode != 200) {
        return FailureResult.withMessage(response.body);
      }
      final results = jsonDecode(response.body) as List;
      final artists = results
          .map((e) => YoutubeArtist.fromMap(e).setIdIfNull(useBrowseId: true))
          .toList();
      return artists.asResult;
    });
  }

  @override
  FutureOrResult<List<BasePlaylist>> searchPlaylists(String term, int page) {
    // TODO: implement searchPlaylists
    throw UnimplementedError();
  }

  @override
  FutureOrResult<List<BaseTrack>> searchTracks(String term, int page) async {
    return await Result.fromAnother(() async {
      final response = await http.get(Uri.parse(
        '${serverAddress}searchwithfilter?query=$term&filter=songs&pageNum=$page',
      ));
      if (response.statusCode != 200) {
        return FailureResult.withMessage(response.body);
      }
      final results = jsonDecode(response.body) as List;
      return results.map((e) => YoutubeTrack.fromMap(e)).toList().asResult;
    });
  }

  @override
  FutureOrResult<AllCategoriesSearchResult> searchAll(
      String term, int page) async {
    return await Result.fromAnother(() async {
      final response =
          await http.get(Uri.parse('${serverAddress}search?query=$term'));
      if (response.statusCode != 200) {
        return FailureResult.withMessage(response.body);
      }
      final List results = jsonDecode(response.body)['output'];

      List<BaseArtist> artists = [];
      List<YoutubeAlbum> albums = [];
      List<YoutubeTrack> tracks = [];
      List<YoutubePlaylist> playlists = [];

      for (var map in results) {
        switch (map['category']) {
          case 'Artists':
            artists
                .add(YoutubeArtist.fromMap(map).setIdIfNull(useBrowseId: true));
          case 'Albums':
            albums.add(YoutubeAlbum.fromMap(map));
          case 'Songs':
            tracks.add(YoutubeTrack.fromMap(map));
          case 'Featured playlists':
            playlists.add(YoutubePlaylist.fromMap(map));
          case 'Community playlists':
            playlists.add(YoutubePlaylist.fromMap(map));
          case 'Top result':
            switch (map['resultType']) {
              case 'Artists':
                artists.add(
                    YoutubeArtist.fromMap(map).setIdIfNull(useBrowseId: true));
              case 'Albums':
                albums.add(YoutubeAlbum.fromMap(map));
              case 'Songs':
                tracks.add(YoutubeTrack.fromMap(map));
              case 'Featured playlists':
                playlists.add(YoutubePlaylist.fromMap(map));
              case 'Community playlists':
                playlists.add(YoutubePlaylist.fromMap(map));
            }
        }
      }
      return AllCategoriesSearchResult(
        albums: albums,
        artists: artists,
        tracks: tracks,
        playlists: playlists,
      ).asResult;
    });
  }
}
