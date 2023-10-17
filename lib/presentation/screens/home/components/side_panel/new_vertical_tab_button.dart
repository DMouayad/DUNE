import 'package:dune/navigation/navigation.dart';
import 'package:dune/presentation/utils/constants.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/themes/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewVerticalTabButton extends ConsumerWidget {
  const NewVerticalTabButton({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return FilledButton(
      clipBehavior: Clip.hardEdge,
      onPressed: () => AppNavigation.instance.tabs!.addNewTab(),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(borderRadius: kBorderRadius)),
        fixedSize: MaterialStateProperty.all(
            const Size.fromHeight(kVerticalTabHeight)),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 4)),
        foregroundColor: MaterialStateProperty.all(
            context.colorScheme.onPrimaryContainer.withOpacity(.5)),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return context.colorScheme.onPrimaryContainer.withOpacity(.1);
          }
          return Colors.transparent;
        }),
        textStyle:
            MaterialStateProperty.all(context.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w500,
        )),
      ),
      child: const SizedBox(
        height: kVerticalTabHeight,
        width: double.infinity,
        child: Wrap(
          clipBehavior: Clip.hardEdge,
          runAlignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              height: kVerticalTabHeight,
              width: kVerticalTabHeight,
              child: Icon(Icons.add, size: 20),
            ),
            Text('New Tab'),
          ],
        ),
      ),
    );
  }
}
