import 'package:dune/presentation/custom_widgets/optional_parent_widget.dart';
import 'package:dune/presentation/custom_widgets/desktop_app_bar_buttons.dart';
import 'package:dune/support/helpers/platform_helpers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as acrylic;

class CustomAppBar extends PreferredSize {
  const CustomAppBar({
    super.key,
  }) : super(
            child: const _AppBarWidget(),
            preferredSize: const Size.fromHeight(36));
}

class _AppBarWidget extends ConsumerWidget {
  const _AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final showAppName = !context.isDesktop;
    return OptionalParentWidget(
      condition: isDesktopPlatform,
      parentWidgetBuilder: (child) => DragToMoveArea(child: child),
      childWidget: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        title: acrylic.TitlebarSafeArea(
          child: fluent_ui.Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (showAppName)
                  fluent_ui.SizedBox(
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
                // const CustomSearchBar(
                //     isQuickSearchMode: true, isOnlineSearchMode: true),
                VerticalDivider(
                    thickness: 4, color: context.colorScheme.onBackground),
              ],
            ),
          ),
        ),
        // toolbarHeight: 50,
        actions:
            isDesktopNotWebPlatform ? [const DesktopAppBarButtons()] : null,
      ),
    );
  }
}
