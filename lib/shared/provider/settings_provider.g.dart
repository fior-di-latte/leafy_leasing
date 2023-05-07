// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$settingsRepositoryHash() =>
    r'4764ae9047ef79a0e7ab49ded79d4620da662b84';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef SettingsRepositoryRef
    = AutoDisposeProviderRef<HiveSyncRepository<Settings>>;

/// See also [settingsRepository].
@ProviderFor(settingsRepository)
const settingsRepositoryProvider = SettingsRepositoryFamily();

/// See also [settingsRepository].
class SettingsRepositoryFamily extends Family<HiveSyncRepository<Settings>> {
  /// See also [settingsRepository].
  const SettingsRepositoryFamily();

  /// See also [settingsRepository].
  SettingsRepositoryProvider call({
    required String boxName,
    required String key,
  }) {
    return SettingsRepositoryProvider(
      boxName: boxName,
      key: key,
    );
  }

  @override
  SettingsRepositoryProvider getProviderOverride(
    covariant SettingsRepositoryProvider provider,
  ) {
    return call(
      boxName: provider.boxName,
      key: provider.key,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'settingsRepositoryProvider';
}

/// See also [settingsRepository].
class SettingsRepositoryProvider
    extends AutoDisposeProvider<HiveSyncRepository<Settings>> {
  /// See also [settingsRepository].
  SettingsRepositoryProvider({
    required this.boxName,
    required this.key,
  }) : super.internal(
          (ref) => settingsRepository(
            ref,
            boxName: boxName,
            key: key,
          ),
          from: settingsRepositoryProvider,
          name: r'settingsRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$settingsRepositoryHash,
          dependencies: SettingsRepositoryFamily._dependencies,
          allTransitiveDependencies:
              SettingsRepositoryFamily._allTransitiveDependencies,
        );

  final String boxName;
  final String key;

  @override
  bool operator ==(Object other) {
    return other is SettingsRepositoryProvider &&
        other.boxName == boxName &&
        other.key == key;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, boxName.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$settingsStateHash() => r'b8f7725b2e6d4d13f984f88dcb6e6fb722fddfe1';

/// See also [SettingsState].
@ProviderFor(SettingsState)
final settingsStateProvider =
    AutoDisposeNotifierProvider<SettingsState, Settings>.internal(
  SettingsState.new,
  name: r'settingsStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$settingsStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SettingsState = AutoDisposeNotifier<Settings>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
