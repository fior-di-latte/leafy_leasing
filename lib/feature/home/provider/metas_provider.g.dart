// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metas_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$metasCacheHash() => r'696ec465d2d62201d4586e166b2361ee041e6302';

/// See also [metasCache].
@ProviderFor(metasCache)
final metasCacheProvider =
    AutoDisposeFutureProvider<Cache<AppointmentMetas>>.internal(
  metasCache,
  name: r'metasCacheProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$metasCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MetasCacheRef = AutoDisposeFutureProviderRef<Cache<AppointmentMetas>>;
String _$metasRepositoryHash() => r'f2d656533f5d0903bb61e0c3cbb26dc84f982daa';

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

typedef MetasRepositoryRef
    = AutoDisposeFutureProviderRef<AsyncRepository<AppointmentMetas>>;

/// See also [metasRepository].
@ProviderFor(metasRepository)
const metasRepositoryProvider = MetasRepositoryFamily();

/// See also [metasRepository].
class MetasRepositoryFamily
    extends Family<AsyncValue<AsyncRepository<AppointmentMetas>>> {
  /// See also [metasRepository].
  const MetasRepositoryFamily();

  /// See also [metasRepository].
  MetasRepositoryProvider call({
    required String boxName,
    required String key,
  }) {
    return MetasRepositoryProvider(
      boxName: boxName,
      key: key,
    );
  }

  @override
  MetasRepositoryProvider getProviderOverride(
    covariant MetasRepositoryProvider provider,
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
  String? get name => r'metasRepositoryProvider';
}

/// See also [metasRepository].
class MetasRepositoryProvider
    extends AutoDisposeFutureProvider<AsyncRepository<AppointmentMetas>> {
  /// See also [metasRepository].
  MetasRepositoryProvider({
    required this.boxName,
    required this.key,
  }) : super.internal(
          (ref) => metasRepository(
            ref,
            boxName: boxName,
            key: key,
          ),
          from: metasRepositoryProvider,
          name: r'metasRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$metasRepositoryHash,
          dependencies: MetasRepositoryFamily._dependencies,
          allTransitiveDependencies:
              MetasRepositoryFamily._allTransitiveDependencies,
        );

  final String boxName;
  final String key;

  @override
  bool operator ==(Object other) {
    return other is MetasRepositoryProvider &&
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

String _$metasStateHash() => r'1db1deb5c0ac31b01c68215566fadc9810943df3';

/// See also [MetasState].
@ProviderFor(MetasState)
final metasStateProvider =
    AutoDisposeAsyncNotifierProvider<MetasState, AppointmentMetas>.internal(
  MetasState.new,
  name: r'metasStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$metasStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MetasState = AutoDisposeAsyncNotifier<AppointmentMetas>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
