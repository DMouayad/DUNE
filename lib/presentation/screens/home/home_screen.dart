import 'package:dune/presentation/screens/home/wide_home_screen.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/screens/home/components/app_bar.dart';
import 'package:go_router/go_router.dart';

import 'components/player_bottom_bar/player_bottom_bar.dart';
import 'components/player_widgets/volume_controls.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen(this.body, {Key? key}) : super(key: key);
  final Widget body;

  @override
  Widget build(BuildContext context, ref) {
    final appTheme = ref.watch(appThemeControllerProvider);

    final showBackButton = ref.watch(showBackButtonProvider);
    return Theme(
      data: appTheme.materialThemeData,
      child: Builder(builder: (context) {
        // a [Builder] is used here so all the children of it in the tree
        // have a parent [Theme] widget
        return Scaffold(
          drawer: const Drawer(),
          backgroundColor: Colors.transparent,
          drawerEnableOpenDragGesture: false,
          appBar: const CustomAppBar(),
          body: Stack(
            children: [
              if (context.isDesktopPlatform && showBackButton)
                Positioned(
                  top: 4,
                  left: 4,
                  child: BackButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    color: context.colorScheme.secondary,
                  ),
                ),
              Positioned.fill(
                top: showBackButton ? 33 : 2,
                child: body,
              ),
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: PlayerBottomBar(),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Material(
                  type: MaterialType.transparency,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 14.0, bottom: 9),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        VerticalDivider(
                          color: context.colorScheme.onBackground,
                        ),
                        // the two buttons placed here so the volume level bar is shown
                        // above the entire screen
                        const Padding(
                          padding: EdgeInsets.only(bottom: 3.8),
                          child: VolumeControls(),
                        ),
                        const SizedBox(width: 8),
                        IconButton.filledTonal(
                          onPressed: () => (),
                          icon: Icon(
                            Icons.queue_music_outlined,
                            size: 20,
                            color: context.colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

/**
 *
 * if (nowPlayingSectionDisplayMode.isUnpinned)
    Material(
    type: MaterialType.transparency,
    child: InkWell(
    onTap: () => _hideNowPlayingSection(ref),
    child: AbsorbPointer(
    child: Container(color: Colors.black54),
    ),
    ),
    ),
    AnimatedPositioned(
    duration: const Duration(milliseconds: 360),
    curve: Curves.fastEaseInToSlowEaseOut,
    right: nowPlayingSectionDisplayMode.isUnpinned
    ? 0
    : -unpinnedNowPlayingSectionWidth,
    top: 0,
    bottom: 0,
    child: Visibility(
    visible: nowPlayingSectionDisplayMode.isUnpinned,
    child: Material(
    color: context.colorScheme.surface,
    elevation: 10,
    borderRadius: const BorderRadius.horizontal(
    left: Radius.circular(8)),
    child: nowPlayingSectionCard,
    ),
    ),
    ),
 */
