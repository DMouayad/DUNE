import 'package:dune/data/app_preferences/isar/isar_app_preferences.dart';
import 'package:dune/data/audio/isar/models/isar_album.dart';
import 'package:dune/data/audio/isar/models/isar_artist.dart';
import 'package:dune/data/audio/isar/models/isar_category_playlists.dart';
import 'package:dune/data/audio/isar/models/isar_play_history.dart';
import 'package:dune/data/audio/isar/models/isar_track.dart';
import 'package:dune/data/audio/isar/models/isar_playlist.dart';
import 'package:dune/data/audio/isar/models/isar_track_record.dart';
import 'package:dune/data/audio/isar/models/isar_user_playlist.dart';
import 'package:dune/data/theme/isar_app_theme.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarHelper {
  static Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();

    return await Isar.open(
      [
        IsarPlaylistSchema,
        IsarTrackSchema,
        IsarArtistSchema,
        IsarAlbumSchema,
        IsarListeningHistorySchema,
        IsarAppThemeSchema,
        IsarUserPlaylistSchema,
        IsarAppPreferencesSchema,
        IsarTrackRecordSchema,
        IsarCategoryPlaylistsSchema,
      ],
      directory: dir.path,
    );
  }
}
