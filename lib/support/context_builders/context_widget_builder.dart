import 'package:flutter/material.dart';

import 'context_builder.dart';

class ContextWidgetBuilder extends StatelessWidget {
  final ContextBuilder<Widget> builder;

  const ContextWidgetBuilder(this.builder, {super.key});

  @override
  Widget build(BuildContext context) {
    return builder.getCurrentContextChild(context);
  }
}
