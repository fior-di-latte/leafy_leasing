import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:leafy_leasing/shared/base.dart';

part 'internet_connection_provider.g.dart';

@riverpod
StreamSubscription<InternetConnectionStatus> internetConnection(
    InternetConnectionRef ref) {
  final streamSubscription = getInternetCheckStream();
  ref.onDispose(streamSubscription.cancel);
  return streamSubscription;
}
