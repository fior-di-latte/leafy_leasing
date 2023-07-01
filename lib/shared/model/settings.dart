// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Project imports:
import 'package:leafy_leasing/shared/base.dart';
import 'package:isar/isar.dart';

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

// @Collection(ignore: {'copyWith', 'locale'})
// @freezed
// @HiveType(typeId: 4)
// class Settings with _$Settings {
//   factory Settings({
//     @HiveField(0) ThemeMode? themeMode,
//     @HiveField(1) String? localeTag,
//   }) = _Settings;
//
//   const Settings._();
//
//   @override
//   @Enumerated(EnumType.ordinal32)
//   // ignore: recursive_getters
//   ThemeMode? get themeMode => themeMode;
//
//   Id get id => Isar.autoIncrement;
//   Locale? get locale => (localeTag != null) ? Locale(localeTag!) : null;
// }
