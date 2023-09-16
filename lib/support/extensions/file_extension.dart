import 'dart:io';
import 'package:path/path.dart' as p;

extension ExtensionsOnFile on File {
  String get extractName {
    final fileNameWithExtension = path.split(p.separator).last;
    final dotIndex = fileNameWithExtension.lastIndexOf('.');
    // return the file name without the extension
    return fileNameWithExtension.substring(0, dotIndex);
  }
}
