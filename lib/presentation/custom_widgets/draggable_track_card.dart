//
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

class DraggableTrackCard extends ConsumerWidget {
  const DraggableTrackCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, ref) {
    // final selectedTracksNames = ref.watch(
    //   currentlySelectedTracksProvider
    //       .select((value) => value.map((e) => e.title).toList()),
    // );
    return fluent.Draggable(
      feedback: Text("HELLo"),
      onDragCompleted: () {},
      feedbackOffset: const fluent.Offset(140, -40),
      child: child,
    );
  }
}
