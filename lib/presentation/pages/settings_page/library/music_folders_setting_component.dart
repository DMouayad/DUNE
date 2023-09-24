import 'package:dune/domain/app_preferences/base_app_preferences.dart';
import 'package:dune/presentation/controllers/local_library_controller.dart';
import 'package:dune/presentation/custom_widgets/dune_loading_widget.dart';
import 'package:dune/presentation/pages/settings_page/common/setting_component_card.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/presentation/utils/music_folder_helper.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicFoldersSettingComponent extends ConsumerWidget {
  const MusicFoldersSettingComponent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentFolders =
        ref.watch(appPreferencesController.select((s) => s.localMusicFolders));
    return SettingComponentCard(
      title: 'Music folders',
      iconData: Icons.folder_open_outlined,
      children: [
        const _LibraryStateInfo(),
        ListTile(
          title: Text(
            'Specify where to look for music on your device',
            style: context.textTheme.bodyMedium,
          ),
          trailing: Consumer(builder: (context, ref, _) {
            return TextButton.icon(
              label: const Text('Add folder'),
              icon: const Icon(Icons.file_open_outlined),
              onPressed: () => onAddMusicFolder(ref),
            );
          }),
        ),
        const Divider(),
        ListView.builder(
          shrinkWrap: true,
          itemCount: currentFolders.length,
          itemBuilder: (context, index) {
            return _MusicFolderTile(currentFolders.elementAt(index));
          },
        ),
      ],
    );
  }

  void onAddMusicFolder(WidgetRef ref) async {
    final selectedPath = await FilePicker.platform.getDirectoryPath(
      lockParentWindow: true,
      dialogTitle: 'Add folder to your library',
    );

    final musicFolder = MusicFolderHelper.createInstance(
      selectedPath,
      ref.watch(appPreferencesController).localMusicFolders,
    );
    if (musicFolder != null) {
      ref.read(appPreferencesController.notifier).addMusicFolder(musicFolder);
      ref
          .read(localLibraryControllerProvider.notifier)
          .addNewMusicFolder(musicFolder.path);
    }
  }
}

class _MusicFolderTile extends ConsumerWidget {
  _MusicFolderTile(this.folder)
      : super(key: Key(folder.path.hashCode.toString()));
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
            removeFolderFromLibrary(ref, folder.path);
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
                      // also remove the tracks in this sub folder
                      removeFolderFromLibrary(ref, e);
                    },
                  ),
                ),
              )
              .toList(),
        ]);
  }

  void removeFolderFromLibrary(WidgetRef ref, String folderPath) {
    ref
        .read(localLibraryControllerProvider.notifier)
        .removeMusicFolder(folderPath);
  }
}

class _LibraryStateInfo extends ConsumerWidget {
  const _LibraryStateInfo();

  @override
  Widget build(BuildContext context, ref) {
    final libraryState = ref.watch(localLibraryControllerProvider);
    return AnimatedSwitcher(
      reverseDuration: const Duration(milliseconds: 700),
      duration: const Duration(milliseconds: 700),
      child: () {
        if (libraryState.runtimeType == LocalLibraryState) {
          return const SizedBox.shrink();
        }

        final ({String title, Widget trailing}) tileContents =
            switch (libraryState.runtimeType) {
          AddingMusicFolderState => (
              title: 'Adding new tracks...',
              trailing: const DuneLoadingWidget(size: 18),
            ),
          RemovingMusicFolderState => (
              title: 'Cleaning up...',
              trailing: const DuneLoadingWidget(size: 18),
            ),
          FolderWasRemovedLocalLibraryState => (
              title:
                  '"${(libraryState as FolderWasRemovedLocalLibraryState).removedTracksCount}" '
                  'tracks were removed from your library',
              trailing: const Icon(Icons.check_circle_outline),
            ),
          FolderWasAddedLocalLibraryState => (
              title:
                  '"${(libraryState as FolderWasAddedLocalLibraryState).addedTracksCount}" '
                  'tracks were added to your library',
              trailing: const Icon(Icons.check_circle_outline),
            ),
          _ => (title: '', trailing: const SizedBox.shrink()),
        };

        return Card(
          margin: const EdgeInsets.all(10),
          color: context.colorScheme.primaryContainer,
          child: ListTile(
            dense: true,
            textColor: context.colorScheme.onPrimaryContainer,
            leading: const Icon(Icons.info_outline),
            title: Text(tileContents.title),
            trailing: tileContents.trailing,
          ),
        );
      }(),
    );
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
