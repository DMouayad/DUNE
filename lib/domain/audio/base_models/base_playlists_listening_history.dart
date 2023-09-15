import 'package:dune/support/extensions/extensions.dart';
import 'package:equatable/equatable.dart';

import 'base_playlist.dart';

class BasePlaylistsListeningHistory<P extends BasePlaylist> extends Equatable {
  /// The date the [items] were listened to on.
  final DateTime date;

  /// List of playlists which were played on the specified [date]
  final List<P> items;

  const BasePlaylistsListeningHistory({
    required this.date,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.toString(),
      'items': items.map((e) => e.toMap()).toList(),
    };
  }

  @override
  List<Object?> get props => [date.onlyDate, items];

  BasePlaylistsListeningHistory copyWithAddedPlaylists(List<P> items) {
    return copyWith(
      items: {...this.items, ...items}.toList(),
    );
  }

  BasePlaylistsListeningHistory copyWith({
    DateTime? date,
    List<P>? items,
  }) {
    return BasePlaylistsListeningHistory(
      date: date ?? this.date,
      items: items ?? this.items,
    );
  }
}
