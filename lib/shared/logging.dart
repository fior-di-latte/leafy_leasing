///  Declarative Logging:
///  * on provider change
///  * on route change
///  * on cache change
///  * on internet retry attempt
///  * on internet status change (see internetConnectionProvider)
///  * on local state change (see useLoggedState)

import 'package:leafy_leasing/shared/base.dart';

const kProviderMaxLogLength = 80;
final logger = Logger(printer: PrettyPrinter(methodCount: 0));

extension on ProviderBase<dynamic> {
  static final providerTimestamps = <ProviderBase<dynamic>, DateTime>{};

  void saveTimestamp() => providerTimestamps[this] = DateTime.now();

  String get timeSinceLastUpdate {
    final lastUpdate = providerTimestamps[this];
    if (lastUpdate == null) {
      return 'unknown ms';
    }
    final duration = DateTime.now().difference(lastUpdate);
    return '${duration.inMilliseconds} ms';
  }

  String get customName {
    final usedName = name ?? 'unnamedProvider';
    final id = argument?.toString();
    return '$usedName ${id != null ? '($id)' : ''}';
  }
}

class ProviderDisposeLogger extends ProviderObserver {
  @override
  void didDisposeProvider(
    ProviderBase<dynamic> provider,
    ProviderContainer container,
  ) {
    logger.v('P-Dispose of ${provider.customName}.');
  }
}

class ProviderAddLogger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<dynamic> provider,
    Object? value,
    ProviderContainer container,
  ) {
    provider.saveTimestamp();
    logger.v('P-Add of ${provider.customName}.');
  }
}

class ProviderUpdateLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (previousValue is AsyncData && newValue is AsyncLoading) {
      provider.saveTimestamp();
    }
    if (previousValue is AsyncLoading &&
        newValue is AsyncData &&
        !provider.customName.contains('Repository') &&
        !provider.customName.contains('Cache')) {
      logger.d(
        'Loading Time for ${provider.customName}:'
        ' ${provider.timeSinceLastUpdate}',
      );
    }
    logger.v(
      'P-Update of ${provider.customName}:\n\t"Previous Value":'
      ' "$previousValue"'
      '\n\t"New Value": '
      '"$newValue}"',
    );
  }
}

final devProviderLoggers = <ProviderObserver>[
  ProviderAddLogger(),
  ProviderDisposeLogger(),
  ProviderUpdateLogger()
]; // these loggers are registered on 'debug' level!

class CustomRouteObserver extends AutoRouterObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logger.i('New route pushed: ${route.settings.name}');
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    logger.i('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    logger.i('Tab route re-visited: ${route.name}');
  }
}

Cache<T> addLoggersToIsarCache<T>(Cache<T> cache, {required String name}) =>
    cache
      ..on<CacheEntryCreatedEvent<T>>().listen(
        (event) => logger.v('IsarCache $name: "${event.entry.key}" added'),
      )
      ..on<CacheEntryUpdatedEvent<T>>().listen(
        (event) => logger.v('IsarCache $name: "${event.newEntry.key}" updated'),
      )
      ..on<CacheEntryRemovedEvent<T>>().listen(
        (event) => logger.v('IsarCache $name: "${event.entry.key}" removed'),
      )
      ..on<CacheEntryExpiredEvent<T>>().listen(
        (event) => logger.v('IsarCache $name: "${event.entry.key}" expired'),
      )
      ..on<CacheEntryEvictedEvent<T>>().listen(
        (event) => logger.v('IsarCache $name: "${event.entry.key}" evicted'),
      );

void logOnNetworkRetry<T>(String? id, Exception e, {bool isPut = false}) =>
    logger.e('Network Error: Retrying to ${isPut ? 'put' : 'fetch'} $T $id.'
        ' Exception $e');
