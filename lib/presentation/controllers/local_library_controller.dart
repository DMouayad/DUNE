import 'package:dune/domain/audio/base_models/music_library.dart';
import 'package:dune/domain/audio/facades/music_facade.dart';
import 'package:dune/support/models/query_options.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../support/logger_service.dart';

final class LocalLibraryController extends StateNotifier<LocalLibraryState> {
  LocalLibraryController() : super(LocalLibraryState(library: MusicLibrary()));

  void loadLibraryFromStorage() async {
    const qOptions = QueryOptions(limit: 30);
    (await MusicFacade.localMusicLibrary.getLibrary(qOptions)).fold(
      onSuccess: (lib) => state = state.copyWith(library: lib),
      onFailure: (err) => Log.e(err),
    );
  }

  Future<void> addNewMusicFolder(String path) async {
    state = AddingMusicFolderState(library: state.library);
    MusicFacade.localMusicLibrary.addMusicFolder(path).foldThen(
          onSuccess: (result) {
            state = FolderWasAddedLocalLibraryState(
              library: result.library,
              addedTracksCount: result.addedTracksCount,
            );
            Future.delayed(const Duration(seconds: 4), () {
              state = LocalLibraryState(library: state.library);
            });
          },
          onFailure: (err) => Log.e(err),
        );
  }

  Future<void> removeMusicFolder(String path) async {
    state = RemovingMusicFolderState(library: state.library);
    MusicFacade.localMusicLibrary.removeMusicFolder(path).foldThen(
          onSuccess: (result) {
            state = FolderWasRemovedLocalLibraryState(
                library: result.library,
                removedTracksCount: result.removedTracksCount);
            Future.delayed(const Duration(seconds: 4), () {
              state = LocalLibraryState(library: state.library);
            });
          },
          onFailure: (err) => Log.e(err),
        );
  }
}

class LocalLibraryState extends Equatable {
  final MusicLibrary library;

  const LocalLibraryState({required this.library});

  @override
  List<Object?> get props => [library];

  LocalLibraryState copyWith({MusicLibrary? library}) {
    return LocalLibraryState(library: library ?? this.library);
  }
}

class FolderWasAddedLocalLibraryState extends LocalLibraryState {
  const FolderWasAddedLocalLibraryState(
      {required super.library, required this.addedTracksCount});

  final int addedTracksCount;

  @override
  List<Object?> get props => [...super.props, addedTracksCount];
}

class AddingMusicFolderState extends LocalLibraryState {
  const AddingMusicFolderState({required super.library});
}

class RemovingMusicFolderState extends LocalLibraryState {
  const RemovingMusicFolderState({required super.library});
}

class FolderWasRemovedLocalLibraryState extends LocalLibraryState {
  const FolderWasRemovedLocalLibraryState(
      {required super.library, required this.removedTracksCount});

  final int removedTracksCount;

  @override
  List<Object?> get props => [...super.props, removedTracksCount];
}
