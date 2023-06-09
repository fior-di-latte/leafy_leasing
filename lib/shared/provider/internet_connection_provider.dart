import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:leafy_leasing/shared/base.dart';

part 'internet_connection_provider.g.dart';

@riverpod
Stream<InternetConnectionStatus> internetConnection(InternetConnectionRef ref) {
  if (kIsWeb) {
    // a stream that emits a single value, InternetConnectionStatus.connected
    return Stream.fromIterable([InternetConnectionStatus.connected]);
  }

  final checker =
      InternetConnectionChecker.createInstance(checkInterval: 3.seconds);

  final subscription = checker.onStatusChange.listen((status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        logger.i('Data connection is available.');
        break;
      case InternetConnectionStatus.disconnected:
        logger.w('You are disconnected from the internet.');
        break;
    }
  });
  ref.onDispose(subscription.cancel);
  return checker.onStatusChange;
}
