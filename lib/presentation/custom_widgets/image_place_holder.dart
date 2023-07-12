import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ImagePlaceHolder extends StatelessWidget {
  const ImagePlaceHolder({super.key, this.size});

  final Size? size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        constraints: size != null ? BoxConstraints.tight(size!) : null,
        color: context.colorScheme.surfaceVariant,
        child: Icon(
          Icons.music_note_outlined,
          size: 22,
          color: context.colorScheme.secondary,
        ),
      ),
    );
  }
}
