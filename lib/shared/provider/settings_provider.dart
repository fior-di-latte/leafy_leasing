import 'package:leafy_leasing/shared/base.dart';

import 'package:leafy_leasing/shared/repository/abstract_repository.dart';
import 'package:leafy_leasing/shared/repository/hive_repository.dart';

import '../data_services/hive.dart';

part 'settings_provider.g.dart';

typedef SettingsRepository = HiveSyncRepository<Settings>;

@riverpod
SettingsRepository settingsRepository(
  Ref ref, {
  required String boxName,
  required String key,
}) {
  return HiveRepositorySyncImpl<Settings>(boxName, key: key);
}

@riverpod
class SettingsState extends _$SettingsState {
  late SettingsRepository _repository;
  @override
  Settings build() {
    _repository = ref.watch(
        settingsRepositoryProvider(key: hiveSettings, boxName: hiveSettings));
    return _repository.get()!;
  }

  void setLocale(String localeTag) {
    _repository.put(state.copyWith(localeTag: localeTag));
    ref.invalidateSelf();
  }

  void setThemeMode(ThemeMode themeMode) {
    _repository.put(state.copyWith(themeMode: themeMode));
    ref.invalidateSelf();
  }
}
