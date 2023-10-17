import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/cupertino.dart';

import 'page_body_wrapper.dart';

class NewTabPage extends StatelessWidget {
  const NewTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageBodyWrapper(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.waveform_path,
            color: context.colorScheme.primary,
          ),
          const Text(
            'New tab for you to discover all types of music',
          ),
        ],
      ),
    );
  }
}
