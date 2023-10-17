import 'package:dune/navigation/navigation.dart';
import 'package:dune/support/extensions/extensions.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/test_with_datasets.dart';

void main() {
  test('it adds new location to history and set it as the current one', () {
    var location = Location(path: '/pages/page1', name: 'test', extra: null);
    final history = NavigationHistory.empty().withLocationAdded(location);
    expect(history.currentLocation, location);
  });
  test('it updates current location when adding new ones', () {
    final location = Location(path: '/pages/page1', name: 'test', extra: null);
    final history = NavigationHistory.empty()
        .withLocationAdded(location)
        .withNextLocationSelected();
    expect(history.currentLocation, location);
  });
  test('it returns previous & current locations', () {
    final firstLocation = Location(path: '/pages/page1', name: 'test');
    final secondLocation =
        Location(path: '/pages/page2', name: 'test2', extra: "extra");
    var history = NavigationHistory.empty()
        .withLocationAdded(firstLocation)
        .withLocationAdded(secondLocation);

    expect(history.currentLocation, secondLocation);
    expect(history.getPreviousOfCurrentLocation(), firstLocation);
    history = history.withPreviousLocationSelected();
    expect(history.currentLocation, firstLocation);
    expect(history.getNextOfCurrentLocation(), secondLocation);
  });
  test(
    'it doesnt move newly selected location if it already exists and is previous/next of current one',
    () {
      final locations = LocationFactory().createMany(4);
      var history = NavigationHistory(
        groups: LocationGroups.of(
          {0: LocationGroup(locations: locations, currentLocationIndex: 2)},
        ),
      );
      expect(_isCurrent(history, locations[2]), true);
      expect(history.hasForward(), true);
      expect(history.hasPrevious(), true);
      // now set the first location as the current one.
      history = history.withLocationSelected(locations[1]);
      expect(_isCurrent(history, locations[1]), true);
      // assert its position(index) was not changed
      expect(history.getPreviousOfCurrentLocation()?.path, locations[0].path);
      expect(history.getNextOfCurrentLocation()?.path, locations[2].path);
    },
  );
  test(
    'it moves newly selected location to the end if it already exists and is not'
    ' the previous nor the next of current one',
    () {
      final locations = LocationFactory().createMany(5);
      final currentLocation = locations.elementAt(3);
      final locationToSelect = locations.elementAt(1);
      var history = NavigationHistory(
        groups: LocationGroups.of(
          {0: LocationGroup(locations: locations, currentLocationIndex: 3)},
        ),
      );
      expect(_isCurrent(history, currentLocation), true);
      expect(history.hasForward(), true);
      expect(history.hasPrevious(), true);
      // act
      history = history.withLocationSelected(locationToSelect);
      // expect it was [locationToSelect] moved to the last index in
      // the [NavigationHistory.currentGroup.locations] since it doesn't have a relation with [currentLocation]
      expect(_isCurrent(history, locationToSelect), true);
      expect(history.hasForward(), false);
      expect(history.getPreviousOfCurrentLocation()?.path, locations.last.path);
    },
  );
  testWithDatasets<RemovingLocationGroupTestDataset>(
    'it removes specified navigation group',
    datasets: [
      (initialGroup: 0, groupsCount: 2, removedGroup: 1, expectedGroup: 0),
      (initialGroup: 0, groupsCount: 2, removedGroup: 0, expectedGroup: 1),
      (initialGroup: 1, groupsCount: 2, removedGroup: 1, expectedGroup: null),
    ],
    testBody: (dataset) {
      final locationGroups = _createGroups(dataset.groupsCount);
      var history = NavigationHistory(
          initialGroupIndex: dataset.initialGroup, groups: locationGroups);

      expect(
          history.currentGroup, locationGroups.whereKey(dataset.initialGroup));
      // act
      history = history.withGroupRemovedAt(dataset.removedGroup);
      // assert current group is the group at specified index
      expect(
        history.currentGroup,
        locationGroups.whereKey(dataset.expectedGroup),
      );
    },
  );
  test('it updates current group index', () {
    const locationsCount = 3;
    const currentGroupIndex = 1;
    final firstGroup =
        LocationGroupFactory().create(locationsCount: locationsCount);
    final secondGroup =
        LocationGroupFactory().create(locationsCount: locationsCount);

    var history = NavigationHistory(
      initialGroupIndex: currentGroupIndex,
      groups: LocationGroups.of({0: firstGroup, 1: secondGroup}),
    );
    // assert we have the second group at [currentGroupIndex]
    expect(history.currentGroup, secondGroup);
    // act
    history = history.withCurrentGroupIndexChanged(0);
    // assert
    expect(history.currentGroup, firstGroup);
  });
  test('it updates the order of groups', () {
    const locationsCount = 3;
    const currentGroupIndex = 1;
    final firstGroup =
        LocationGroupFactory().create(locationsCount: locationsCount);
    final secondGroup =
        LocationGroupFactory().create(locationsCount: locationsCount);

    var history = NavigationHistory(
      initialGroupIndex: currentGroupIndex,
      groups: LocationGroups.of({0: firstGroup, 1: secondGroup}),
    );
    // assert we're in the group with index of 1
    expect(history.currentGroup, secondGroup);
    // act
    history = history.withGroupsReordered(1, 0);
    // assert locations at [currentGroupIndex] is now the first locations
    expect(history.currentGroup, firstGroup);
  });
}

bool _isCurrent(NavigationHistory history, Location location) {
  return history.currentLocation?.path == location.path;
}

LocationGroups _createGroups(int count) {
  return LocationGroups.fromEntries(List.generate(
    count,
    (index) => MapEntry(
      index,
      LocationGroupFactory().create(locations: LocationFactory().createMany(2)),
    ),
  ));
}

class LocationFactory {
  LocationFactory();

  List<Location> createMany(int count) =>
      List.generate(count, (index) => create());

  Location create({String? path, String? name, Object? extra}) {
    return Location(
      path: path ?? faker.lorem.sentence(),
      name: name ?? faker.lorem.word(),
      extra: extra,
    );
  }
}

class LocationGroupFactory {
  LocationGroup create({
    int? locationsCount,
    List<Location> locations = const [],
    int? currentLocationIndex,
  }) {
    return LocationGroup(
      locations: locationsCount != null
          ? LocationFactory().createMany(locationsCount)
          : locations,
      currentLocationIndex: currentLocationIndex ?? locations.length - 1,
    );
  }
}

typedef RemovingLocationGroupTestDataset = ({
  int initialGroup,
  int groupsCount,
  int removedGroup,

  /// Indicates the after-act expected group index (the index in the initial created
  /// groups and assigned as [NavigationHistory.groups]).
  ///
  /// when it is [null], this means [NavigationHistory.currentGroup] is expected to be [null].
  int? expectedGroup,
});
