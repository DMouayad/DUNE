import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/custom_widgets/search_icon_button.dart';
import 'package:dune/support/extensions/context_extensions.dart';

import 'components/player_bottom_bar/player_bottom_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen(this.body, {Key? key}) : super(key: key);
  final Widget body;

  @override
  Widget build(BuildContext context, ref) {
    final appTheme = ref.watch(appThemeControllerProvider);

    return Material(
      type: MaterialType.transparency,
      child: Theme(
        data: appTheme.materialThemeData,
        child: Builder(builder: (context) {
          // a [Builder] is used here so all the children of it in the tree
          // have a parent [Theme] widget
          return Scaffold(
            drawer: const Drawer(),
            drawerEnableOpenDragGesture: false,
            body: body,
            appBar: AppBar(
              titleSpacing: 0,
              elevation: 0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      'DUNE',
                      textAlign: TextAlign.start,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.secondary,
                        fontFamily: 'bruno_ace',
                        // letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const Spacer(),
                  VerticalDivider(
                      thickness: 4, color: context.colorScheme.onBackground),
                ],
              ),
              actions: const [SearchIconButton()],
            ),
            bottomNavigationBar: const PlayerBottomBar(),
          );
        }),
      ),
    );
  }
}
