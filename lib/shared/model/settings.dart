// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Project imports:
import 'package:leafy_leasing/shared/base.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@freezed
@HiveType(typeId: 4)
class Settings with _$Settings {
  factory Settings({
    @HiveField(0) ThemeMode? themeMode,
    @HiveField(1) String? localeTag,
  }) = _Settings;

  const Settings._();
  Locale? get locale => (localeTag != null) ? Locale(localeTag!) : null;
}
