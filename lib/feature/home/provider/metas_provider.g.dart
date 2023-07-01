// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metas_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$metasRepositoryCacheHash() =>
    r'5990c36fcd01f484f2a0cfecc01876722588f3fb';

/// See also [metasRepositoryCache].
@ProviderFor(metasRepositoryCache)
final metasRepositoryCacheProvider = AutoDisposeFutureProvider<
    (MetasRepository, Cache<AppointmentMetas>)>.internal(
  metasRepositoryCache,
  name: r'metasRepositoryCacheProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$metasRepositoryCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MetasRepositoryCacheRef
    = AutoDisposeFutureProviderRef<(MetasRepository, Cache<AppointmentMetas>)>;
String _$metasStateHash() => r'dbbaa9317b80fecfd9193e5e6a7de65cea325c4f';

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
