import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/utils/navigation_helper.dart';
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
          _CustomIconButton(
            tooltip: ref.watch(appPreferencesController).sidePanelPinned
                ? 'Minimize panel'
                : 'Expand panel',
            iconData: fluent.FluentIcons.side_panel,
            onPressed: () {
              ref
                  .read(appPreferencesController.notifier)
                  .toggleSidePanelPinMode();
            },
          ),
          _CustomIconButton(
            tooltip: 'Show Settings',
            iconData: context.isDesktopPlatform
                ? fluent.FluentIcons.settings
                : Icons.settings_outlined,
            onPressed: () => NavigationHelper.showSettingsDialog(context),
          ),
          if (tabsMode.isEnabled)
            _CustomIconButton(
              tooltip: 'Browsing history',
              onPressed: () {},
              iconData: fluent.FluentIcons.history,
            ),
          Consumer(
            builder: (context, ref, child) {
              return _CustomIconButton(
                tooltip: 'Go back',
                iconData: fluent.FluentIcons.back,
                onPressed: _onBackButtonPressed(ref),
              );
            },
          ),
          if (tabsMode.isEnabled)
            _CustomIconButton(
              tooltip: 'Go forward',
              iconData: fluent.FluentIcons.forward,
              onPressed: () {},
            ),
        ],
      ),
    );
  }

  void Function()? _onBackButtonPressed(WidgetRef ref) {
    return () {
      if (AppRouter.router.canPop()) {
        AppRouter.router.pop();
        if (AppRouter.tabsModeEnabled) {
          ref
              .read(tabsStateProvider.notifier)
              .update((state) => state.withPreviousPageSelected());
        }
      }
    };
  }
}

class _CustomIconButton extends StatelessWidget {
  const _CustomIconButton({
    required this.onPressed,
    required this.iconData,
    required this.tooltip,
  });

  final void Function()? onPressed;
  final IconData iconData;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return fluent.Tooltip(
      message: tooltip,
      child: fluent.IconButton(
        iconButtonMode: fluent.IconButtonMode.small,
        style: fluent.ButtonStyle(
          padding: fluent.ButtonState.all(
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
          foregroundColor: fluent.ButtonState.resolveWith((states) {
            return states.isDisabled ? null : context.colorScheme.secondary;
          }),
          shape: fluent.ButtonState.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
        ),
        icon: fluent.Icon(iconData),
        onPressed: onPressed,
      ),
    );
  }
}
