import 'dart:math';

import 'package:faker/faker.dart';

extension ListExtensions<T> on List<T> {
  List<String> toStringList() {
    final l = <String>[];
    for (var i in this) {
      l.add(i.toString());
    }
    return l;
  }

  void addIfNotPresent(value) {
    if (!contains(value)) {
      add(value);
    }
  }

  bool hasType(Type type) {
    return where((element) => element.runtimeType == type).isNotEmpty;
  }

  (T, int) randomElementWithIndex() {
    final randomIndex = Random().nextInt(length - 1);
    return (elementAt(randomIndex), randomIndex);
  }

  T get randomElement {
    final randomIndex = Random().nextInt(length - 1);
    return elementAt(randomIndex);
  }

  T firstWhereType(Type type) {
    return (this).whereType().first;
  }

  bool containsWhere(bool Function(T element) condition) {
    return firstWhereOrNull(condition) != null;
  }

  T? firstWhereOrNull(bool Function(T element) condition) {
    try {
      return (this).where((e) => condition(e)).first;
    } on StateError {
      return null;
    }
  }

  T? firstWhereAnyOrNull(List<bool> Function(T element) conditions) {
    try {
      return firstWhere((T e) {
        for (bool cond in conditions(e)) {
          if (cond) return cond;
        }
        return false;
      });
    } on StateError {
      return null;
    }
  }
}

extension MapKeys<K, V> on Map<K, V> {
  V? whereKey(K? key) {
    if (containsKey(key)) {
      return this[key];
    }
    return null;
  }

  V? valueOfAnyKey(List<K> keys) {
    return entries
        .toList()
        .firstWhereOrNull((e) => keys.contains(e.key))
        ?.value;
  }
}

extension IterableExtension on Iterable {
  get firstOrNull {
    try {
      return first;
    } on StateError {
      return null;
    }
  }
}

extension DurationExtension on Duration {
  String get formatInHhMmSs {
    final hh = (inHours).toString().padLeft(2, '0');
    final mm = (inMinutes % 60).toString().padLeft(2, '0');
    final ss = (inSeconds % 60).toString().padLeft(2, '0');

    return '${hh != '00' ? '$hh:' : ''}$mm:$ss';
  }
}

extension DateTimeExtension on DateTime {
  /// returns a new [DateTime] with only the ([year], [month], [day]) properties.
  DateTime get onlyDate => DateTime(year, month, day);
}

extension FakerExtension on Faker {
  DateTime get randomDateFromCurrentMonth {
    final now = DateTime.now();
    return date
        .dateTimeBetween(
          DateTime(now.year, now.month),
          DateTime(now.year, now.month, 31),
        )
        .onlyDate;
  }
}
