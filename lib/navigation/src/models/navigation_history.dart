import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:dune/support/logger_service.dart';
import 'package:equatable/equatable.dart';

typedef LocationGroupIndex = int;
typedef LocationGroups = HashMap<LocationGroupIndex, LocationGroup>;

base class NavigationHistory extends Equatable {
  final LocationGroups _groups;
  final int _currentGroupIndex;

  const NavigationHistory({
    required LocationGroups groups,
    LocationGroupIndex initialGroupIndex = 0,
  })  : _groups = groups,
        _currentGroupIndex = initialGroupIndex;

  factory NavigationHistory.empty({LocationGroupIndex currentGroup = 0}) {
    return NavigationHistory(
      initialGroupIndex: currentGroup,
      groups: LocationGroups.fromEntries(
        [MapEntry(currentGroup, const LocationGroup())],
      ),
    );
  }

  LocationGroup? get currentGroup => _groups.whereKey(_currentGroupIndex);

  // Returns the current(last-visited) location in the current group.
  Location? get currentLocation => currentGroup?.currentLocation;

  int get groupsCount => _groups.length;

  bool hasPrevious() => currentGroup?.hasPrevious() ?? false;

  bool hasForward() => currentGroup?.hasForward() ?? false;

  /// Adds the given [location] to the current [LocationGroup].
  /// Returns an updated instance of this history.
  NavigationHistory withLocationAdded(Location location) {
    return _withCurrentGroupUpdated(currentGroup?.withLocationAdded(location));
  }

  Location? getPreviousOfCurrentLocation() {
    return currentGroup?.getPreviousOfCurrentLocation();
  }

  Location? getNextOfCurrentLocation() {
    return currentGroup?.getNextOfCurrentLocation();
  }

  /// Returns a copy of this instance after updating current [LocationGroup.index].
  NavigationHistory withPreviousLocationSelected() {
    return _withCurrentGroupUpdated(
      currentGroup?.withPreviousLocationSelected(),
    );
  }

  /// Returns a copy of this instance after updating current [LocationGroup.index].
  NavigationHistory withNextLocationSelected() {
    return _withCurrentGroupUpdated(
      currentGroup?.withNextLocationSelected(),
    );
  }

  NavigationHistory withCurrentGroupIndexChanged(int value) {
    return _copyWith(currentGroupIndex: value);
  }

  /// Clears the history of visited [Location]s of the specified group with
  /// [groupIndex].
  /// **NOTE**: It doesn't automatically update the [_currentGroupIndex].
  NavigationHistory withGroupRemovedAt(int groupIndex) {
    var newGroups = LocationGroups.of(_groups);
    newGroups.remove(groupIndex);
    newGroups = LocationGroups.fromIterable(
      newGroups.values.indexed,
      key: (e) => (e as (int, LocationGroup)).$1,
      value: (e) => (e as (int, LocationGroup)).$2,
    );
    return _copyWith(groups: newGroups);
  }

  NavigationHistory withGroupsReordered(int oldIndex, int newIndex) {
    final groupAtNewIndex = _groups.whereKey(newIndex);
    final groupAtOldIndex = _groups.whereKey(oldIndex);
    if (groupAtOldIndex == null || groupAtNewIndex == null) {
      Log.f(
        "Trying to swap two locations group but one of them does not exist."
        "\n item at old index: $groupAtOldIndex.\nItem at new index: $groupAtNewIndex",
      );
      return this;
    }
    final newGroups = LocationGroups.of(_groups);
    // swap old with new
    newGroups.update(
      oldIndex,
      (value) => groupAtNewIndex,
      ifAbsent: () => groupAtNewIndex,
    );
    // swap new with old
    newGroups.update(
      newIndex,
      (value) => groupAtOldIndex,
      ifAbsent: () => groupAtOldIndex,
    );
    return _copyWith(groups: newGroups);
  }

  NavigationHistory _withCurrentGroupUpdated(LocationGroup? newGroup) {
    if (newGroup == null) return this;
    final newGroups = LocationGroups.of(_groups);
    newGroups.update(
      _currentGroupIndex,
      (value) => newGroup,
      ifAbsent: () => newGroup,
    );
    return _copyWith(groups: newGroups);
  }

  NavigationHistory _copyWith({
    LocationGroups? groups,
    int? currentGroupIndex,
  }) {
    return NavigationHistory(
      groups: groups ?? _groups,
      initialGroupIndex: currentGroupIndex ?? _currentGroupIndex,
    );
  }

  NavigationHistory withLocationSelected(Location? location) {
    if (location == null) {
      return this;
    }
    return _withCurrentGroupUpdated(
      currentGroup?.withLocationSelected(location),
    );
  }

  NavigationHistory withGroupAdded(int index, {Location? initialLocation}) {
    final newGroups = LocationGroups.of(_groups)
      ..addAll({
        index: LocationGroup(
          locations: initialLocation != null ? [initialLocation] : [],
        )
      });
    return _copyWith(groups: newGroups);
  }

  @override
  List<Object?> get props => [_groups, _currentGroupIndex];
}

class LocationGroup extends Equatable {
  final List<Location> locations;
  final int currentLocationIndex;

  const LocationGroup({
    this.locations = const [],
    this.currentLocationIndex = 0,
  });

  Location? get currentLocation =>
      locations.elementAtOrNull(currentLocationIndex);

  bool hasPrevious() => currentLocationIndex != 0;

  bool hasForward() => currentLocationIndex != locations.length - 1;

  LocationGroup withLocationAdded(Location location) {
    final newLocationsCount = (locations.length + 1);
    return _copyWith(
      locations: {...locations, location}.toList(),
      currentLocationIndex: newLocationsCount - 1,
    );
  }

  Location? getPreviousOfCurrentLocation() {
    return currentLocationIndex == 0
        ? null
        : locations.elementAtOrNull(currentLocationIndex - 1);
  }

  Location? getNextOfCurrentLocation() {
    return locations.elementAtOrNull(currentLocationIndex + 1);
  }

  LocationGroup withPreviousLocationSelected() {
    if (currentLocationIndex < 1 || locations.length < 2) {
      Log.w("selecting previous location when we only have one.");
      return this;
    }
    return _copyWith(currentLocationIndex: currentLocationIndex - 1);
  }

  LocationGroup withNextLocationSelected() {
    if (currentLocationIndex == locations.length - 1 || locations.length == 1) {
      return this;
    }
    return _copyWith(currentLocationIndex: currentLocationIndex + 1);
  }

  LocationGroup withLocationSelected(Location location) {
    if (currentLocation == location) return this;
    final locationIndex = locations.indexWhere((e) => e.path == location.path);
    if (locationIndex == -1) return withLocationAdded(location);

    // update [Location.lastVisitedAt]
    var newGroup = _withLocationLastVisitedAtUpdated(locationIndex);
    // if newly selected location is the next/previous of current one
    // we DO NOT change the position of the selected location so the user can still
    // navigate forward or backward from this new location.
    if (_isNextOrPrevious(location)) {
      return newGroup._copyWith(currentLocationIndex: locationIndex);
    }
    return newGroup
        ._withLocationMovedToLast(locationIndex)
        ._copyWith(currentLocationIndex: locations.length - 1);
  }

  @override
  List<Object?> get props => [locations, currentLocationIndex];

  LocationGroup _copyWith({
    List<Location>? locations,
    int? currentLocationIndex,
  }) {
    return LocationGroup(
      locations: locations ?? this.locations,
      currentLocationIndex: currentLocationIndex ?? this.currentLocationIndex,
    );
  }

  LocationGroup _withLocationLastVisitedAtUpdated(int locationIndex) {
    final newLocations = [...locations];
    newLocations[locationIndex] = newLocations
        .elementAt(locationIndex)
        .copyWith(lastVisitedAt: DateTime.now());

    return _copyWith(locations: newLocations);
  }

  LocationGroup _withLocationMovedToLast(int locationIndex) {
    final newLocations = locations.toList();
    final loc = newLocations.removeAt(locationIndex);
    newLocations.add(loc);
    return _copyWith(locations: newLocations);
  }

  bool _isNextOrPrevious(Location location) {
    return location.path == getNextOfCurrentLocation()?.path ||
        location.path == getPreviousOfCurrentLocation()?.path;
  }
}

/// Represents a page which a user visited (navigated to)
class Location extends Equatable {
  final String path;
  final String name;
  final Object? extra;
  final DateTime lastVisitedAt;

  Location({
    required this.path,
    required this.name,
    DateTime? lastVisitedAt,
    this.extra,
  }) : lastVisitedAt = lastVisitedAt ?? DateTime.now();

  @override
  List<Object?> get props => [path, name, lastVisitedAt, extra];

  Location copyWith({
    String? path,
    String? name,
    Object? extra,
    DateTime? lastVisitedAt,
  }) {
    return Location(
      path: path ?? this.path,
      name: name ?? this.name,
      extra: extra ?? this.extra,
      lastVisitedAt: lastVisitedAt ?? this.lastVisitedAt,
    );
  }
}
