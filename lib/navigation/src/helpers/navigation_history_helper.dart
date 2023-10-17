part of '../app_navigation.dart';

///
class NavigationHistoryHelper {
  NavigationHistoryHelper(
    NavigationHistory initialState,
    Location initialLocation,
  ) : _navigationHistoryNotifier = ValueNotifier(initialState);
  final ValueNotifier<NavigationHistory> _navigationHistoryNotifier;

  NavigationHistory get _state => _navigationHistoryNotifier.value;

  Location? get _currentLocation => _state.currentLocation;

  void addListener(void Function(NavigationHistory) onChange) {
    _navigationHistoryNotifier.addListener(() => onChange(_state));
  }

  /// Called whenever a route has been pushed/popped.
  void onRouterLocationChanged() {
    final newLocationPath = AppNavigation.instance.currentLocation;
    if (_currentLocation?.path != newLocationPath && newLocationPath != null) {
      final extra = _getExtra();

      final newLocation = Location(
        path: newLocationPath,
        extra: extra,
        lastVisitedAt: DateTime.now(),
        name: _getCurrentRoute(newLocationPath)?.name ??
            _nameFromExtra(extra) ??
            '',
      );
      _onUpdateState(newLocation);
    }
  }

  Object? _getExtra() {
    final s = AppNavigation
        .instance.currentRouter.routeInformationProvider.value.state;
    final Object? extra = s is RouteInformationState<Object?> ? s.extra : null;
    return extra;
  }

  BaseRoute? _getCurrentRoute(String? newLocationPath) {
    return AppNavigation
            .instance.currentRouter.routeInformationParser.configuration.routes
            .firstWhereOrNull(
                (route) => route is BaseRoute && route.path == newLocationPath)
        as BaseRoute?;
  }

  /// Returns a location name based on it's route [RouteInformationState.extra]
  String? _nameFromExtra(Object? extra) {
    if (extra is BaseArtist) return extra.name;
    if (extra is BaseTrack) return extra.title;
    if (extra is BaseAlbum) return extra.title;
    if (extra is BasePlaylist) return extra.title;
    if (extra is BaseExploreMusicItem) return extra.title;
    if (extra is BaseExploreMusicCollection) return extra.title;
    return null;
  }

  void _onUpdateState(Location? newLocation) {
    Log.d("current state: $_state");
    final newState = _state.withLocationSelected(newLocation);
    if (newState.currentLocation != _state.currentLocation) {
      _navigationHistoryNotifier.value = newState;
      Log.d("new state: $_state");
    }
  }

  void onPrevious() {
    _navigationHistoryNotifier.value = _state.withPreviousLocationSelected();
  }

  Location? onForward() {
    final lastPopped = _state.getNextOfCurrentLocation();
    _navigationHistoryNotifier.value = _state.withNextLocationSelected();
    return lastPopped;
  }

  /// When tabs are disabled, this is used to update the current routes stack
  /// we will pushing to.
  void onCurrentStatefulBranchChanged(QuickNavDestination dest) {
    _navigationHistoryNotifier.value =
        _state.withCurrentGroupIndexChanged(dest.destinationIndex);
  }

  void updateCurrentLocationGroupIndex(int index) {
    _navigationHistoryNotifier.value =
        _state.withCurrentGroupIndexChanged(index);
  }

  void reorderNavigationStack(int oldIndex, int newIndex) {
    if (oldIndex == newIndex) return;
    _navigationHistoryNotifier.value =
        _state.withGroupsReordered(oldIndex, newIndex);
  }

  void removeLocationGroupAt(int index) {
    _navigationHistoryNotifier.value = _state.withGroupRemovedAt(index);
  }

  /// Adds a new locations group
  void addNewGroup(int index, Location initialLocation) {
    _navigationHistoryNotifier.value = _state.withGroupAdded(
      index,
      initialLocation: initialLocation,
    );
  }
}
