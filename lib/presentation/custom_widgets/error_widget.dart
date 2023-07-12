import 'package:dune/support/extensions/context_extensions.dart';
import 'package:dune/support/utils/error/app_error.dart';
import 'package:dune/support/utils/error/app_exception.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DuneErrorWidget extends StatelessWidget {
  const DuneErrorWidget(this.error, {this.onRetry, super.key});

  final Object? error;
  final void Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    final (String, IconData) errorInfo;
    if (error is AppError) {
      errorInfo = _getErrorInfoByAppError();
    } else {
      errorInfo = ("An error occurred", FontAwesomeIcons.faceSadCry);
    }

    final double cardDimension = context.isDesktop ? 300 : 200;
    return Center(
      child: SizedBox(
        width: context.screenWidth * .8,
        height: cardDimension,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              errorInfo.$2,
              color: context.isDarkMode
                  ? context.colorScheme.errorContainer
                  : context.colorScheme.error,
              size: context.isDesktop ? 28 : 28,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                // color: context.colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: context.colorScheme.error),
              ),
              child: Text(
                errorInfo.$1,
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.onErrorContainer,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 30),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text("Retry..."),
              ),
            ]
          ],
        ),
      ),
    );
  }

  (String, IconData) _getErrorInfoByAppError() {
    return switch ((error as AppError).appException) {
      AppException.noConnectionFound => (
          "You're Offline\nPlease check your internet connection.",
          Icons.wifi_off
        ),
      AppException.cannotConnectToServer => (
          "We're unable to connect to the server\nPlease check your internet connection.",
          Icons.not_interested,
        ),
      _ => ("An error occurred", Icons.error_outline_rounded),
    };
  }
}
