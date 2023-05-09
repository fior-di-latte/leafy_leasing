import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loggy/loggy.dart';

InternetConnectionChecker getInternetConnectionChecker() =>
    InternetConnectionChecker()
      ..onStatusChange.listen((status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            logInfo('Data connection is available.');
            break;
          case InternetConnectionStatus.disconnected:
            logWarning('You are disconnected from the internet.');
            break;
        }
      });
