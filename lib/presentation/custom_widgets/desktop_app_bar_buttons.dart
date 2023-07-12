import 'package:fluent_ui/fluent_ui.dart';
import 'package:window_manager/window_manager.dart';

class DesktopAppBarButtons extends StatelessWidget {
  const DesktopAppBarButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 40,
      child: WindowCaption(
        backgroundColor: Colors.transparent,
        brightness: theme.brightness,
        // backgroundColor: Colors.transparent,
      ),
    );
  }
}
