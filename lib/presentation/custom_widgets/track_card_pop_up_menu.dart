import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

class TrackCardPopupMenu extends StatelessWidget {
  const TrackCardPopupMenu(
    this.track, {
    this.onDelete,
    this.onDownload,
    this.onSelectTrack,
    this.onPlayTrack,
    this.additionalItems = const [],
    super.key,
  });

  final BaseTrack track;
  final void Function()? onDelete;
  final void Function()? onSelectTrack;
  final void Function()? onPlayTrack;
  final void Function()? onDownload;
  final List<({String text, IconData icon, void Function()? onPressed})>
      additionalItems;

  @override
  Widget build(BuildContext context) {
    return fluent.MenuFlyout(
      items: [
        fluent.MenuFlyoutItem(
          leading: const Icon(fluent.FluentIcons.play),
          text: const Text('Play'),
          onPressed: () => _handleItemPressed(onPlayTrack, context),
        ),
        fluent.MenuFlyoutItem(
          leading: const Icon(fluent.FluentIcons.multi_select),
          text: const Text('Select'),
          onPressed: () => _handleItemPressed(onSelectTrack, context),
        ),
        fluent.MenuFlyoutItem(
          leading: const Icon(Icons.person, size: 12),
          text: const Text('Go to artist page'),
          onPressed: () {},
        ),
        fluent.MenuFlyoutItem(
          leading: const Icon(Icons.album_outlined, size: 12),
          text: const Text('Go to album page'),
          onPressed: () {},
        ),
        if (onDownload != null)
          fluent.MenuFlyoutItem(
            leading: const Icon(fluent.FluentIcons.download),
            text: const Text('Download'),
            onPressed: () => _handleItemPressed(onDownload, context),
          ),
        if (onDelete != null)
          fluent.MenuFlyoutItem(
            leading: const Icon(fluent.FluentIcons.delete),
            text: const Text('Delete'),
            onPressed: () => _handleItemPressed(onDelete, context),
          ),
        ...additionalItems
            .map((e) => fluent.MenuFlyoutItem(
                  leading: Icon(e.icon),
                  text: Text(e.text),
                  onPressed: () => _handleItemPressed(e.onPressed, context),
                ))
            .toList(),
      ],
    );
  }

  void _handleItemPressed(
    void Function()? onPressed,
    BuildContext context,
  ) {
    if (onPressed != null) {
      fluent.Flyout.of(context).close();
      onPressed();
    }
  }
}
