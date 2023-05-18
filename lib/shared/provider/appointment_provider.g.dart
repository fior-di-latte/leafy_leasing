// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appointmentCacheHash() => r'10506a1dab9300e1d789315e8de72dcec3a4ab98';

/// See also [appointmentCache].
@ProviderFor(appointmentCache)
final appointmentCacheProvider =
    AutoDisposeFutureProvider<Cache<Appointment>>.internal(
  appointmentCache,
  name: r'appointmentCacheProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appointmentCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppointmentCacheRef = AutoDisposeFutureProviderRef<Cache<Appointment>>;
String _$appointmentRepositoryHash() =>
    r'3a72f8cdef415615792f1b99d0e1736331df22a2';

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

typedef AppointmentRepositoryRef
    = AutoDisposeFutureProviderRef<AsyncCachedRepository<Appointment>>;

/// See also [appointmentRepository].
@ProviderFor(appointmentRepository)
const appointmentRepositoryProvider = AppointmentRepositoryFamily();

/// See also [appointmentRepository].
class AppointmentRepositoryFamily
    extends Family<AsyncValue<AsyncCachedRepository<Appointment>>> {
  /// See also [appointmentRepository].
  const AppointmentRepositoryFamily();

  /// See also [appointmentRepository].
  AppointmentRepositoryProvider call({
    required String key,
  }) {
    return AppointmentRepositoryProvider(
      key: key,
    );
  }

  @override
  AppointmentRepositoryProvider getProviderOverride(
    covariant AppointmentRepositoryProvider provider,
  ) {
    return call(
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
  String? get name => r'appointmentRepositoryProvider';
}

/// See also [appointmentRepository].
class AppointmentRepositoryProvider
    extends AutoDisposeFutureProvider<AsyncCachedRepository<Appointment>> {
  /// See also [appointmentRepository].
  AppointmentRepositoryProvider({
    required this.key,
  }) : super.internal(
          (ref) => appointmentRepository(
            ref,
            key: key,
          ),
          from: appointmentRepositoryProvider,
          name: r'appointmentRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$appointmentRepositoryHash,
          dependencies: AppointmentRepositoryFamily._dependencies,
          allTransitiveDependencies:
              AppointmentRepositoryFamily._allTransitiveDependencies,
        );

  final String key;

  @override
  bool operator ==(Object other) {
    return other is AppointmentRepositoryProvider && other.key == key;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$appointmentStateHash() => r'9e9ffd4d2c9de8fd4b6851a5ba8ae92c2d69e9c3';

abstract class _$AppointmentState
    extends BuildlessAutoDisposeAsyncNotifier<Appointment> {
  late final String id;

  FutureOr<Appointment> build(
    String id,
  );
}

/// See also [AppointmentState].
@ProviderFor(AppointmentState)
const appointmentStateProvider = AppointmentStateFamily();

/// See also [AppointmentState].
class AppointmentStateFamily extends Family<AsyncValue<Appointment>> {
  /// See also [AppointmentState].
  const AppointmentStateFamily();

  /// See also [AppointmentState].
  AppointmentStateProvider call(
    String id,
  ) {
    return AppointmentStateProvider(
      id,
    );
  }

  @override
  AppointmentStateProvider getProviderOverride(
    covariant AppointmentStateProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'appointmentStateProvider';
}

/// See also [AppointmentState].
class AppointmentStateProvider extends AutoDisposeAsyncNotifierProviderImpl<
    AppointmentState, Appointment> {
  /// See also [AppointmentState].
  AppointmentStateProvider(
    this.id,
  ) : super.internal(
          () => AppointmentState()..id = id,
          from: appointmentStateProvider,
          name: r'appointmentStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$appointmentStateHash,
          dependencies: AppointmentStateFamily._dependencies,
          allTransitiveDependencies:
              AppointmentStateFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is AppointmentStateProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<Appointment> runNotifierBuild(
    covariant AppointmentState notifier,
  ) {
    return notifier.build(
      id,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
