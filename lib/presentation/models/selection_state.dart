// ignore_for_file: public_member_api_docs, sort_constructors_first
class SelectionState<T extends Object> {
  final bool selectionEnabled;
  final Map<String, T> selectedValues;
  final String Function(T item) itemToString;

  SelectionState(
    this.selectionEnabled,
    this.selectedValues, {
    required this.itemToString,
  });

  factory SelectionState.initial({
    required String Function(T item) itemToString,
  }) {
    return SelectionState(false, {}, itemToString: itemToString);
  }

  SelectionState<T> copyWith({
    bool? selectionEnabled,
    Map<String, T>? selectedValues,
    String Function(T item)? itemToString,
  }) {
    return SelectionState<T>(
      selectionEnabled ?? this.selectionEnabled,
      selectedValues ?? this.selectedValues,
      itemToString: itemToString ?? this.itemToString,
    );
  }
}
