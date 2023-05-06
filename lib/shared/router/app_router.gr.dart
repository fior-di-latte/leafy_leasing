// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
    PendingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PendingScreen(),
      );
    },
    CanceledRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CanceledScreen(),
      );
    },
    DoneRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DoneScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    AppointmentRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AppointmentRouteArgs>(
          orElse: () => AppointmentRouteArgs(id: pathParams.getString('id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AppointmentScreen(
          args.id,
          key: args.key,
        ),
      );
    },
    CancelAppointmentRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CancelAppointmentRouteArgs>(
          orElse: () =>
              CancelAppointmentRouteArgs(id: pathParams.getString('id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CancelAppointmentScreen(
          args.id,
          key: args.key,
        ),
      );
    },
    CloseAppointmentRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CloseAppointmentRouteArgs>(
          orElse: () =>
              CloseAppointmentRouteArgs(id: pathParams.getString('id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CloseAppointmentScreen(
          args.id,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PendingScreen]
class PendingRoute extends PageRouteInfo<void> {
  const PendingRoute({List<PageRouteInfo>? children})
      : super(
          PendingRoute.name,
          initialChildren: children,
        );

  static const String name = 'PendingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CanceledScreen]
class CanceledRoute extends PageRouteInfo<void> {
  const CanceledRoute({List<PageRouteInfo>? children})
      : super(
          CanceledRoute.name,
          initialChildren: children,
        );

  static const String name = 'CanceledRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DoneScreen]
class DoneRoute extends PageRouteInfo<void> {
  const DoneRoute({List<PageRouteInfo>? children})
      : super(
          DoneRoute.name,
          initialChildren: children,
        );

  static const String name = 'DoneRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AppointmentScreen]
class AppointmentRoute extends PageRouteInfo<AppointmentRouteArgs> {
  AppointmentRoute({
    required String id,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AppointmentRoute.name,
          args: AppointmentRouteArgs(
            id: id,
            key: key,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'AppointmentRoute';

  static const PageInfo<AppointmentRouteArgs> page =
      PageInfo<AppointmentRouteArgs>(name);
}

class AppointmentRouteArgs {
  const AppointmentRouteArgs({
    required this.id,
    this.key,
  });

  final String id;

  final Key? key;

  @override
  String toString() {
    return 'AppointmentRouteArgs{id: $id, key: $key}';
  }
}

/// generated route for
/// [CancelAppointmentScreen]
class CancelAppointmentRoute extends PageRouteInfo<CancelAppointmentRouteArgs> {
  CancelAppointmentRoute({
    required String id,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CancelAppointmentRoute.name,
          args: CancelAppointmentRouteArgs(
            id: id,
            key: key,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'CancelAppointmentRoute';

  static const PageInfo<CancelAppointmentRouteArgs> page =
      PageInfo<CancelAppointmentRouteArgs>(name);
}

class CancelAppointmentRouteArgs {
  const CancelAppointmentRouteArgs({
    required this.id,
    this.key,
  });

  final String id;

  final Key? key;

  @override
  String toString() {
    return 'CancelAppointmentRouteArgs{id: $id, key: $key}';
  }
}

/// generated route for
/// [CloseAppointmentScreen]
class CloseAppointmentRoute extends PageRouteInfo<CloseAppointmentRouteArgs> {
  CloseAppointmentRoute({
    required String id,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CloseAppointmentRoute.name,
          args: CloseAppointmentRouteArgs(
            id: id,
            key: key,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'CloseAppointmentRoute';

  static const PageInfo<CloseAppointmentRouteArgs> page =
      PageInfo<CloseAppointmentRouteArgs>(name);
}

class CloseAppointmentRouteArgs {
  const CloseAppointmentRouteArgs({
    required this.id,
    this.key,
  });

  final String id;

  final Key? key;

  @override
  String toString() {
    return 'CloseAppointmentRouteArgs{id: $id, key: $key}';
  }
}
