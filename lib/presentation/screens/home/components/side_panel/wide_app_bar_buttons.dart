import 'package:dune/navigation/src/app_navigation.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WideAppBarButtons extends ConsumerWidget {
  const WideAppBarButtons({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final tabsMode = ref.read(appPreferencesController).tabsMode;
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        spacing: 1,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          AppBarIconButton(
            tooltip: ref.watch(appPreferencesController).sidePanelPinned
                ? 'Un-pin side panel'
                : 'Pin side panel',
            iconData: fluent.FluentIcons.side_panel,
            onPressed: () {
              ref
                  .read(appPreferencesController.notifier)
                  .toggleSidePanelPinMode();
            },
          ),
          AppBarIconButton(
            tooltip: 'Show Settings',
            iconData: context.isDesktopPlatform
                ? fluent.FluentIcons.settings
                : Icons.settings_outlined,
            onPressed: () => AppNavigation.instance.showSettingsDialog(context),
          ),
          if (tabsMode.isEnabled)
            AppBarIconButton(
              tooltip: 'Browsing history',
              onPressed: () {},
              iconData: fluent.FluentIcons.history,
            ),
          ValueListenableBuilder(
            valueListenable: AppNavigation.instance.hasPrevious,
            builder: (context, state, _) {
              return AppBarIconButton(
                tooltip: 'Go back',
                iconData: fluent.FluentIcons.back,
                onPressed: state ? AppNavigation.instance.onGoBack : null,
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: AppNavigation.instance.hasForward,
            builder: (context, state, _) {
              return AppBarIconButton(
                tooltip: 'Go forward',
                iconData: fluent.FluentIcons.forward,
                onPressed: state ? AppNavigation.instance.onGoForward : null,
              );
            },
          ),
        ],
      ),
    );
  }
}

class AppBarIconButton extends StatelessWidget {
  const AppBarIconButton({
    super.key,
    required this.onPressed,
    required this.iconData,
    required this.tooltip,
  });

  final void Function()? onPressed;
  final IconData iconData;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return context.isDesktopPlatform
        ? fluent.Tooltip(
            message: tooltip,
            child: fluent.IconButton(
              iconButtonMode: fluent.IconButtonMode.small,
              style: fluent.ButtonStyle(
                padding: fluent.ButtonState.all(
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
                foregroundColor: fluent.ButtonState.resolveWith((states) {
                  return states.isDisabled
                      ? null
                      : context.colorScheme.secondary;
                }),
                shape: fluent.ButtonState.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6))),
                backgroundColor: fluent.ButtonState.all(Colors.transparent),
              ),
              icon: fluent.Icon(iconData),
              onPressed: onPressed,
            ),
          )
        : IconButton(
            tooltip: tooltip,
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : context.colorScheme.secondary;
              }),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
            ),
            iconSize: 14,
            icon: Icon(iconData),
            onPressed: onPressed,
          );
  }
}
