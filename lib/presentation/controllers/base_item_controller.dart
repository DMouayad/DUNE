import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/utils/result/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseItemPageController<ItemType>
    extends StateNotifier<AsyncValue<ItemType?>> {
  BaseItemPageController({
    required FutureOrResult<ItemType?> Function(String itemId)
        getItemFromLocalSource,
    required FutureOrResult<ItemType?> Function(
            String itemId, MusicSource musicSource)
        getItemFromOriginSource,
    required bool Function(ItemType? a, ItemType? b) localItemEqualsOrigin,
  }) : super(const AsyncData(null)) {
    _getItemFromLocalSource = getItemFromLocalSource;
    _getItemFromOriginSource = getItemFromOriginSource;
    _localItemEqualsOrigin = localItemEqualsOrigin;
  }

  late final FutureOrResult<ItemType?> Function(String itemId)
      _getItemFromLocalSource;
  late final FutureOrResult<ItemType?> Function(
      String itemId, MusicSource musicSource) _getItemFromOriginSource;
  late final bool Function(ItemType? a, ItemType? b) _localItemEqualsOrigin;

  Future<void> get(String itemId, MusicSource musicSource) async {
    state = AsyncLoading<ItemType?>()
        .copyWithPrevious(AsyncData(state.valueOrNull));

    (await _getItemFromLocalSource(itemId)).foldAsync(
      onSuccess: (item) async {
        print('fetched local item: ${item.runtimeType}');
        if (item != null) {
          print('item found in local storage');
          state =
              AsyncLoading<ItemType?>().copyWithPrevious(AsyncValue.data(item));
        }
        (await _getItemFromOriginSource(itemId, musicSource)).fold(
          onSuccess: (remoteItem) {
            print('fetched item from remote datasource');
            if (_localItemEqualsOrigin(remoteItem, state.valueOrNull)) {
              state = AsyncData(state.value);
              print("item has same value");
            } else {
              print("item has new value");
              state = AsyncData(remoteItem);
            }
          },
          onFailure: (error) async {
            if (state.hasValue) {
              state = AsyncValue<ItemType?>.error(error, error.stackTrace)
                  .copyWithPrevious(AsyncData(state.requireValue));
            } else {
              state = AsyncValue<ItemType>.error(error, error.stackTrace);
            }
          },
        );
      },
      onFailure: (error) async {
        state = AsyncValue.error(error, error.stackTrace);
      },
    );
  }
}
