import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

const kVersion = '1.0.0';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return fluent.Expander(
      header: Row(
        children: [
          Icon(
            Icons.info,
            color: context.colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Text(
            'About',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colorScheme.secondary,
            ),
          ),
        ],
      ),
      content: Column(
        children: [
          ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14),
            title: Text('Version', style: context.textTheme.titleSmall),
            trailing: const Text(kVersion),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 14),
            title: Text('Developer', style: context.textTheme.titleSmall),
            trailing: TextButton.icon(
              onPressed: () {
                launchUrl(
                  Uri.parse('https://github.com/DMouayad'),
                  mode: LaunchMode.externalApplication,
                );
              },
              icon: const Icon(FontAwesomeIcons.github),
              label: Text(
                'Mouayad Alhamwi',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.isDarkMode
                      ? Colors.grey.shade500
                      : Colors.grey.shade600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
