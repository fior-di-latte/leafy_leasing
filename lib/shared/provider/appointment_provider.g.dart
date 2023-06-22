// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appointmentRepositoryCacheHash() =>
    r'6b39d9397a2eb51e55b2d8c49f2c323d8fb87931';

/// See also [appointmentRepositoryCache].
@ProviderFor(appointmentRepositoryCache)
final appointmentRepositoryCacheProvider = AutoDisposeFutureProvider<
    (AppointmentRepository, Cache<Appointment>)>.internal(
  appointmentRepositoryCache,
  name: r'appointmentRepositoryCacheProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appointmentRepositoryCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppointmentRepositoryCacheRef
    = AutoDisposeFutureProviderRef<(AppointmentRepository, Cache<Appointment>)>;
String _$appointmentStateHash() => r'4da8f61c7509f736245b1483d951230a8deb7e60';

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
