import 'package:dune/navigation/app_router.dart';
import 'package:dune/presentation/custom_widgets/dune_loading_widget.dart';
import 'package:dune/presentation/providers/state_controllers.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DesktopSplashScreen extends ConsumerStatefulWidget {
  const DesktopSplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _DesktopSplashScreenState();
}

class _DesktopSplashScreenState extends ConsumerState<DesktopSplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      context.goNamed(RouteName.explorePage);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height / 4,
            child: DuneLoadingWidget(
              size: 210,
              color: ref.read(appThemeControllerProvider).primaryColor,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'DUNE',
            style: context.textTheme.headlineLarge?.copyWith(
              fontFamily: 'bruno_ace',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'The ultimate music destination',
            style: context.textTheme.titleMedium?.copyWith(
              fontFamily: 'baloo2',
              color: context.colorScheme.onSurface.withOpacity(.8),
            ),
          ),
        ],
      ),
    );
  }
}
