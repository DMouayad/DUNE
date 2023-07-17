import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dune/presentation/models/selection_state.dart';
export 'package:dune/presentation/models/selection_state.dart';

class SelectionController<V extends Object>
    extends StateNotifier<SelectionState<V>> {
  SelectionController(super.state);

  void addSelection(String key, V value) {
    if (state.selectedValues.containsKey(key)) return;
    state = state.copyWith(
      selectedValues: {...state.selectedValues, key: value},
      selectionEnabled: true,
    );
  }

  void selectAll(Map<String, V> items) {
    state = SelectionState(true, items);
  }

  void toggleSelectionForItem(String key, V value) {
    if (state.selectedValues.containsKey(key)) {
      removeSelection(key);
    } else {
      addSelection(key, value);
    }
  }

  void removeSelection(String key) {
    if (state.selectedValues.containsKey(key)) {
      final currentValues = Map<String, V>.from(state.selectedValues);
      currentValues.remove(key);
      state = state.copyWith(selectedValues: currentValues);
    }
  }

  void cancelSelection() {
    state = SelectionState.initialState();
  }

  void clearSelections() {
    state = SelectionState(true, {});
  }
}
