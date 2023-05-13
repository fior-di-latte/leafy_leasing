import 'package:leafy_leasing/shared/base.dart';

ValueNotifier<T> useLoggedState<T>(T initialData) {
  final result = useState<T>(initialData);
  useValueChanged<T, Object>(result.value, (_, __) {
    logInfo('Local state changed to: ${result.value}');
    return null;
  });
  return result;
}

bool useTimeOutFuture(Duration timeOutDuration) {
  final timer = useMemoized(() => Future.delayed(timeOutDuration, () => true));
  final timerAsFuture = useFuture(timer);
  return timerAsFuture.hasData;
}
