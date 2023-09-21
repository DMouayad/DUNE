import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/presentation/pages/settings_page/common/setting_component_card.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicFoldersSettingComponent extends StatelessWidget {
  const MusicFoldersSettingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingComponentCard(
      title: 'Music folders',
      iconData: Icons.folder_open_outlined,
      children: [
        ListTile(
          title: Text(
            'Specify where to look for music on your device',
            style: context.textTheme.bodyMedium,
          ),
          trailing: Consumer(builder: (context, ref, _) {
            return TextButton.icon(
              label: const Text('choose folder'),
              icon: const Icon(Icons.file_open_outlined),
              onPressed: () => onAddMusicFolder(ref),
            );
          }),
        ),
        const Divider(),
        Consumer(
          builder: (context, ref, child) {
            final currentFolders = ref.watch(
                appPreferencesController.select((s) => s.localMusicFolders));
            return ListView.builder(
              shrinkWrap: true,
              itemCount: currentFolders.length,
              itemBuilder: (context, index) {
                return _MusicFolderTile(currentFolders.elementAt(index));
              },
            );
          },
        ),
      ],
    );
  }

  void onAddMusicFolder(WidgetRef ref) async {
    final selectedFolder = await FilePicker.platform.getDirectoryPath(
      lockParentWindow: true,
      dialogTitle: 'Add folder to your library',
    );

    final prefsController = ref.read(appPreferencesController.notifier);
    if (selectedFolder != null &&
        !prefsController.musicFolderAlreadyExists(selectedFolder)) {
      prefsController.addMusicFolder(selectedFolder);
    }
  }
}

class _MusicFolderTile extends ConsumerWidget {
  _MusicFolderTile(this.folder) : super(key: Key(folder.path));
  final MusicFolder folder;

  @override
  Widget build(BuildContext context, ref) {
    return ExpansionTile(
        clipBehavior: Clip.hardEdge,
        title: Text(
          folder.path,
          style: context.textTheme.bodyMedium,
        ),
        leading: CustomDeleteButton(
          confirmationText: 'Remove this folder?',
          onDeleteConfirmed: () {
            ref
                .read(appPreferencesController.notifier)
                .removeMusicFolder(folder);
          },
        ),
        backgroundColor: context.colorScheme.background,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          ListTile(
            title: Text(
              'Sub folders:',
              style: context.textTheme.titleSmall,
            ),
          ),
          ...folder.subFolders
              .map(
                (e) => ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 22),
                  title: Text(
                    e.replaceAll(folder.path, ''),
                    style: context.textTheme.bodyMedium,
                  ),
                  trailing: CustomDeleteButton(
                    confirmationText: 'Remove this folder?',
                    onDeleteConfirmed: () {
                      ref
                          .read(appPreferencesController.notifier)
                          .removeSubMusicFolder(
                              parentMusicFolder: folder, subFolderPath: e);
                    },
                  ),
                ),
              )
              .toList(),
        ]);
  }
}

class CustomDeleteButton extends StatefulWidget {
  const CustomDeleteButton({
    super.key,
    required this.confirmationText,
    required this.onDeleteConfirmed,
  });

  /// The text to display when the user press on this button.
  final String confirmationText;

  /// The action to perform when the user confirms the delete action.
  final void Function() onDeleteConfirmed;

  @override
  State<CustomDeleteButton> createState() => _CustomDeleteButtonState();
}

class _CustomDeleteButtonState extends State<CustomDeleteButton> {
  bool deletePressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(-.1, 0),
          end: Offset.zero,
        ).animate(animation);
        return SlideTransition(position: offsetAnimation, child: child);
      },
      duration: const Duration(milliseconds: 200),
      child: deletePressed
          ? Card(
              child: Wrap(
                spacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const SizedBox(width: 3),
                  Text(
                    widget.confirmationText,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.error,
                    ),
                  ),
                  TextButton(
                    onPressed: widget.onDeleteConfirmed,
                    child: const Text('confirm'),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                          context.colorScheme.onBackground),
                    ),
                    onPressed: () => setState(() => deletePressed = false),
                    child: const Text('cancel'),
                  ),
                ],
              ),
            )
          : IconButton(
              icon:
                  Icon(Icons.close, size: 20, color: context.colorScheme.error),
              onPressed: () => setState(() => deletePressed = true),
            ),
    );
  }
}
