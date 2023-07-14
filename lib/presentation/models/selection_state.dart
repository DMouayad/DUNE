// ignore_for_file: public_member_api_docs, sort_constructors_first
class SelectionState<T extends Object> {
  final bool selectionEnabled;
  final Map<String, T> selectedValues;

  SelectionState(this.selectionEnabled, this.selectedValues);

  static SelectionState<F> initialState<F extends Object>() {
    return SelectionState<F>(false, {});
  }

  SelectionState<T> copyWith({
    bool? selectionEnabled,
    Map<String, T>? selectedValues,
  }) {
    return SelectionState<T>(
      selectionEnabled ?? this.selectionEnabled,
      selectedValues ?? this.selectedValues,
    );
  }
}
