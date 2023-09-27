import 'package:dune/presentation/pages/settings_page/common/setting_component_card.dart';
import 'package:dune/support/extensions/context_extensions.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:extended_image/extended_image.dart' as extended_image;
import 'package:fluent_ui/fluent_ui.dart';

const _durations = [
  (text: 'in the last 24 hours', duration: Duration(days: 1)),
  (text: 'in the last 2 days', duration: Duration(days: 2)),
  (text: 'in the last week', duration: Duration(days: 7)),
  (text: 'in the last month', duration: Duration(days: 30)),
  (text: 'all time', duration: null),
];

class CacheSettingComponent extends ConsumerWidget {
  const CacheSettingComponent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SettingComponentCard(
      iconData: FluentIcons.data_management_settings,
      title: 'Cache',
      children: [
        ListTile(
          title: Text(
            'Cached images',
            style: context.textTheme.titleSmall,
          ),
          trailing: DropDownButton(
            leading: Icon(
              FluentIcons.delete,
              color: context.colorScheme.error,
              size: 16,
            ),
            title: const Text('clear'),
            items: _durations
                .map((e) => MenuFlyoutItem(
                      text: Text(e.text),
                      onPressed: () {
                        extended_image.clearDiskCachedImages(
                            duration: e.duration);
                      },
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

/**
 * OutlinedButton(
    style: ButtonStyle(
    shape: ButtonState.all(
    const RoundedRectangleBorder(borderRadius: kBorderRadius),
    ),
    foregroundColor: ButtonState.all(context.colorScheme.error),
    border: ButtonState.all(BorderSide(
    width: 1.8,
    color: context.colorScheme.onBackground.withOpacity(.6),
    )),
    ),
    onPressed: () {
    extended_image.clearDiskCachedImages();
    },
    child: const Wrap(spacing: 8, children: [
    Icon(FluentIcons.delete),
    Text('clear'),
    ]),
    ),
 */
