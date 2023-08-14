import 'package:dune/presentation/providers/shared_providers.dart';
import 'package:dune/support/enums/music_source.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchMusicSourceOptionButton extends ConsumerWidget {
  const SearchMusicSourceOptionButton({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      height: 38,
      child: ComboBox<MusicSource>(
        selectedItemBuilder: (context) {
          return MusicSource.values
              .map(
                (e) => Text(
                  'on: ${e.name}',
                  style: context.textTheme.titleSmall?.copyWith(),
                ),
              )
              .toList();
        },
        value: ref.watch(searchBarMusicSourceFilterProvider),
        onChanged: (value) {
          ref
              .read(searchBarMusicSourceFilterProvider.notifier)
              .update((state) => value!);
        },
        items: MusicSource.valuesWithoutUnknown
            .map(
              (e) => ComboBoxItem<MusicSource>(
                  value: e,
                  child: Text(
                    e.name,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            )
            .toList(),
      ),
    );
  }
}
