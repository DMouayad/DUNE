import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'isar_category_playlists.g.dart';

@Collection(ignore: {'props', 'hashCode', 'stringify', 'derived'})
class IsarCategoryPlaylists extends Equatable {
  final Id? id;
  final List<String> playlistsIds;
  final String? categoryId;

  IsarCategoryPlaylists({
    this.id,
    this.categoryId,
    this.playlistsIds = const [],
  });

  @override
  List<Object?> get props => [id, playlistsIds, categoryId];

  IsarCategoryPlaylists copyWith({
    Id? id,
    List<String>? playlistsIds,
    String? categoryId,
  }) {
    return IsarCategoryPlaylists(
      id: id ?? this.id,
      playlistsIds: playlistsIds ?? this.playlistsIds,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}
