import 'package:collection/collection.dart';
import 'package:dune/support/logger_service.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'go_router_helpers.dart';

class TabsRoutersHelper {
  TabsRoutersHelper(String initialPagePath, int selectedTabIndex) {
    notifier = RoutersListNotifier(
      [GoRouterHelpers.getCustomRouterInstance(initialPagePath)],
    );
    currentRouterIndexNotifier = ValueNotifier(selectedTabIndex);
  }

  late ValueNotifier<int> currentRouterIndexNotifier;

  int get currentRouterIndex => currentRouterIndexNotifier.value;
  late final RoutersListNotifier notifier;

  List<GoRouter> get routers => notifier._list;

  GoRouter? get currentRouter {
    if (routers.length <= currentRouterIndex) return null;
    return routers.elementAt(currentRouterIndex);
  }

  void reorderRouters(int oldIndex, int newIndex) {
    notifier.swapItems(oldIndex, newIndex);
  }

  void addNewRouter(String initialLocation) {
    notifier.add(GoRouterHelpers.getCustomRouterInstance(initialLocation));
  }

  void removeRouterAt(int index) {
    if (routers.length <= index) {
      Log.w(
        'Trying to remove a router at index of "$index", while we only have ${routers.length}',
      );
      return;
    }
    notifier.removeAt(index);
  }

  void updateCurrentRouterIndex(int newIndex) {
    currentRouterIndexNotifier.value = newIndex;
  }

  void addListeners({
    void Function(int index)? onCurrentRouterChanged,
    void Function(List<GoRouter> routers)? onRoutersChanged,
  }) {
    if (onCurrentRouterChanged != null) {
      currentRouterIndexNotifier.addListener(
        () => onCurrentRouterChanged(currentRouterIndex),
      );
    }
    if (onRoutersChanged != null) {
      notifier.addListener(() {
        onRoutersChanged(routers);
      });
    }
  }
}

class RoutersListNotifier with ChangeNotifier {
  final List<GoRouter> _list;

  List<GoRouter> get items => _list;

  RoutersListNotifier(this._list);

  void swapItems(int oldIndex, int newIndex) {
    _list.swap(oldIndex, newIndex);
    notifyListeners();
  }

  void removeAt(int index) {
    _list.removeAt(index);
    notifyListeners();
  }

  void add(GoRouter instance) {
    _list.add(instance);
    notifyListeners();
  }
}
