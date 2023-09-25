import 'dart:io';

import 'package:dune/domain/audio/services/audio_files_scanner.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/constants.dart';
import '../../../utils/helpers.dart';

class DumbClass with AudioFilesScanner {}

void main() {
  late final DumbClass placeHolder;
  setUpAll(() => placeHolder = DumbClass());

  final validTestAudioFile = File(kPathToAudioFile);
  void cloneFileToSubDirectory(String tempDir) {
    final subDir = Directory('$tempDir\\subDir');
    subDir.createSync();

    final fileCopyPath = '${subDir.path}\\file_copy2.mp3';
    // copy the audio file to the sub-dir
    validTestAudioFile.copySync(fileCopyPath);
  }

  group('[FilesScanner] mixin tests', () {
    test('it reads files in a directory recursively', () async {
      final projectDir = Directory.current.absolute;
      final assetsTempDir = Directory('${projectDir.path}\\test\\temp');
      await withTempPath(assetsTempDir.path, () async {
        // 1. create the temporary directory
        assetsTempDir.createSync();
        // 2. clone the audio file to the temp directory
        validTestAudioFile.copySync('${assetsTempDir.path}\\file_copy1.mp3');
        // 3.
        cloneFileToSubDirectory(assetsTempDir.path);

        final files = await placeHolder.getAudioFiles(assetsTempDir).toList();
        // we should find the two files we've just cloned, one in [assetsTempDir]
        // and the other in a sub-directory inside [assetsTempDir].
        expectLater(files.length, 2);
      });
    });
  });
}
