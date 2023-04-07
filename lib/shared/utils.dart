import 'package:leafy_leasing/l10n/l10n.dart';
import 'package:leafy_leasing/shared/base.dart';

ValueNotifier<T> useLoggedState<T>(T initialData) {
  final result = useState<T>(initialData);
  useValueChanged<T, Object>(result.value, (_, __) {
    logInfo('Local state changed to: ${result.value}');
    return null;
  });
  return result;
}

extension AddConvenience on BuildContext {
  AppLocalizations get lc => AppLocalizations.of(this);
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  ThemeData get thm => Theme.of(this);
  ColorScheme get cs => Theme.of(this).colorScheme;
  TextTheme get tt => Theme.of(this).textTheme;
  TextTheme get att => Theme.of(this).accentTextTheme;
}
