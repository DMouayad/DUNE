import 'package:isar/isar.dart';

import 'isar_helper.dart';
import 'package:get_it/get_it.dart';

final class DependencyInjector {
  static Future<void> registerIsar() async {
    GetIt.instance
        .registerSingletonAsync<Isar>(() async => await IsarHelper.init());
    return await GetIt.instance.isReady<Isar>();
  }

  static Future<void> registerDataSources() async {
    final isarNotInitialized = !GetIt.instance.isRegistered<Isar>();
    if (isarNotInitialized) {
      await registerIsar();
    }
  }
}
