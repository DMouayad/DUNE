import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:isar/isar.dart';

part 'isar_music_folder.g.dart';

@Embedded(ignore: {'derived', 'subFolders', 'props'})
class IsarMusicFolder extends MusicFolder {
  IsarMusicFolder({
    super.path = '',
    this.subFoldersList = const [],
  }) : super(
          subFolders: subFoldersList.toSet(),
        );

  @override
  Set<Type> get derived => {MusicFolder};

  final List<String> subFoldersList;

  factory IsarMusicFolder.fromBase(MusicFolder base) {
    return IsarMusicFolder(
      path: base.path,
      subFoldersList: base.subFolders.toList(),
    );
  }
}
