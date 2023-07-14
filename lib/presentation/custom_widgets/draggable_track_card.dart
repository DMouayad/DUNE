import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

//
import 'package:dune/domain/audio/base_models/base_track.dart';
import 'package:dune/presentation/models/selection_state.dart';

class DraggableTrackCard extends ConsumerWidget {
  const DraggableTrackCard({
    required this.child,
    required this.selectionState,
    super.key,
  });

  final Widget child;
  final SelectionState<BaseTrack> selectionState;

  @override
  Widget build(BuildContext context, ref) {
    return fluent.Draggable(
      feedback: Text("HELLo"),
      onDragCompleted: () {},
      feedbackOffset: const fluent.Offset(140, -40),
      child: child,
    );
  }
}
