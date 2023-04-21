import 'package:leafy_leasing/shared/base.dart';

class ProviderDisposeLogger extends ProviderObserver with NetworkLoggy {
  @override
  void didDisposeProvider(
    ProviderBase provider,
    ProviderContainer containers,
  ) {
    loggy.debug('P-Dispose of ${_getProviderName(provider)}.');
  }
}

class ProviderAddLogger extends ProviderObserver with NetworkLoggy {
  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    loggy.debug('P-Add of ${_getProviderName(provider)}.');
  }
}

class ProviderUpdateLogger extends ProviderObserver with NetworkLoggy {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    loggy.debug(
        'P-Update of ${_getProviderName(provider)}:\n"New Value": "$newValue"',);
  }
}

String _getProviderName(ProviderBase provider) {
  final name = provider.name ?? 'unnamedProvider';
  final id = provider.argument?.toString() ?? 'globalId';
  return '$name with ID $id';
}

final devProviderLoggers = <ProviderObserver>[
  ProviderAddLogger(),
  ProviderDisposeLogger(),
  ProviderUpdateLogger()
]; // these loggers are registered on 'debug' level!

class CustomRouteObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    logInfo('New route pushed: ${route.settings.name}');
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    logInfo('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    logInfo('Tab route re-visited: ${route.name}');
  }
}
