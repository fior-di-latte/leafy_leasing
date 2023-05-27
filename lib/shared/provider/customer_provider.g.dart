// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$customerRepositoryCacheHash() =>
    r'c043f1ebaa037e900caad64a9323469ead529e4a';

/// See also [customerRepositoryCache].
@ProviderFor(customerRepositoryCache)
final customerRepositoryCacheProvider =
    AutoDisposeFutureProvider<(CustomerRepository, Cache<Customer>)>.internal(
  customerRepositoryCache,
  name: r'customerRepositoryCacheProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customerRepositoryCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CustomerRepositoryCacheRef
    = AutoDisposeFutureProviderRef<(CustomerRepository, Cache<Customer>)>;
String _$customerStateHash() => r'ffff27312a3d322f2d40efe6ff799a204b8504d8';

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

abstract class _$CustomerState
    extends BuildlessAutoDisposeAsyncNotifier<Customer> {
  late final String id;

  FutureOr<Customer> build(
    String id,
  );
}

/// See also [CustomerState].
@ProviderFor(CustomerState)
const customerStateProvider = CustomerStateFamily();

/// See also [CustomerState].
class CustomerStateFamily extends Family<AsyncValue<Customer>> {
  /// See also [CustomerState].
  const CustomerStateFamily();

  /// See also [CustomerState].
  CustomerStateProvider call(
    String id,
  ) {
    return CustomerStateProvider(
      id,
    );
  }

  @override
  CustomerStateProvider getProviderOverride(
    covariant CustomerStateProvider provider,
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
  String? get name => r'customerStateProvider';
}

/// See also [CustomerState].
class CustomerStateProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CustomerState, Customer> {
  /// See also [CustomerState].
  CustomerStateProvider(
    this.id,
  ) : super.internal(
          () => CustomerState()..id = id,
          from: customerStateProvider,
          name: r'customerStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$customerStateHash,
          dependencies: CustomerStateFamily._dependencies,
          allTransitiveDependencies:
              CustomerStateFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is CustomerStateProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<Customer> runNotifierBuild(
    covariant CustomerState notifier,
  ) {
    return notifier.build(
      id,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
