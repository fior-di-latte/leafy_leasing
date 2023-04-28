// Project imports:
import 'package:leafy_leasing/shared/base.dart';

class ProviderDisposeLogger extends ProviderObserver with NetworkLoggy {
  @override
  void didDisposeProvider(
    ProviderBase<dynamic> provider,
    ProviderContainer container,
  ) {
    loggy.debug('P-Dispose of ${_getProviderName(provider)}.');
  }
}

class ProviderAddLogger extends ProviderObserver with NetworkLoggy {
  @override
  void didAddProvider(
    ProviderBase<dynamic> provider,
    Object? value,
    ProviderContainer container,
  ) {
    loggy.debug('P-Add of ${_getProviderName(provider)}.');
  }
}

class ProviderUpdateLogger extends ProviderObserver with NetworkLoggy {
  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    loggy.debug(
      'P-Update of ${_getProviderName(provider)}:\n\t\t"Previous Value":'
      ' "$previousValue"'
      '\n\t\t"New Value": "$newValue"',
    );
  }
}

String _getProviderName(ProviderBase<dynamic> provider) {
  final name = provider.name ?? 'unnamedProvider';
  final id = provider.argument?.toString();
  return '$name ${id != null ? '($id)' : ''}';
}

final devProviderLoggers = <ProviderObserver>[
  ProviderAddLogger(),
  ProviderDisposeLogger(),
  ProviderUpdateLogger()
]; // these loggers are registered on 'debug' level!

class CustomRouteObserver extends AutoRouterObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
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
