import 'dart:io';

import 'package:dune/data/app_preferences/isar/isar_app_preferences.dart';
import 'package:dune/data/audio/isar/models/isar_album.dart';
import 'package:dune/data/audio/isar/models/isar_artist.dart';
import 'package:dune/data/audio/isar/models/isar_category_playlists.dart';
import 'package:dune/data/audio/isar/models/isar_listening_history_month_summary.dart';
import 'package:dune/data/audio/isar/models/isar_playlists_listening_history.dart';
import 'package:dune/data/audio/isar/models/isar_track.dart';
import 'package:dune/data/audio/isar/models/isar_playlist.dart';
import 'package:dune/data/audio/isar/models/isar_track_listening_history.dart';
import 'package:dune/data/audio/isar/models/isar_user_playlist.dart';
import 'package:dune/data/theme/isar_app_theme.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarHelper {
  static Future<Isar> init({
    Directory? directory,
    bool enableInspector = true,
  }) async {
    final dir = directory ?? await getApplicationDocumentsDirectory();

    return await Isar.open(
      [
        IsarPlaylistSchema,
        IsarTrackSchema,
        IsarArtistSchema,
        IsarAlbumSchema,
        IsarAppThemeSchema,
        IsarUserPlaylistSchema,
        IsarPlaylistsListeningHistorySchema,
        IsarTrackListeningHistorySchema,
        IsarListeningHistoryMonthSummarySchema,
        IsarAppPreferencesSchema,
        IsarCategoryPlaylistsSchema,
      ],
      inspector: enableInspector,
      directory: dir.path,
    );
  }

  static Future<Isar> initForTesting() async {
    await Isar.initializeIsarCore(download: true);
    return await init(
      directory: Directory.systemTemp,
      enableInspector: false,
    );
  }
}
