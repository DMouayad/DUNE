import 'package:dune/support/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DuneLoadingWidget extends StatelessWidget {
  final double size;
  final Color? color;
  final Color? backgroundColor;

  const DuneLoadingWidget({
    required this.size,
    this.color,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(6),
      constraints: BoxConstraints.tight(Size.square(size + 35)),
      child: LoadingAnimationWidget.beat(
        color: color ?? context.colorScheme.primary,
        size: size,
      ),
    );
  }
}
