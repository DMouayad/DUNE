import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'package:dune/presentation/providers/state_controllers.dart';

import 'components/player_bottom_bar/player_bottom_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen(this.body, {Key? key}) : super(key: key);
  final Widget body;

  @override
  Widget build(BuildContext context, ref) {
    final appTheme = ref.watch(appThemeControllerProvider);

    return Theme(
      data: appTheme.materialThemeData,
      child: Builder(builder: (context) {
        // a [Builder] is used here so all the children of it in the tree
        // have a parent [Theme] widget
        return Scaffold(
          drawer: const Drawer(),
          backgroundColor: Colors.transparent,
          drawerEnableOpenDragGesture: false,
          body: body,
          extendBody: true,
          bottomNavigationBar: const PlayerBottomBar(),
        );
      }),
    );
  }
}
