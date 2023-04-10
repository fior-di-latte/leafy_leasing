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

extension AddCustomLoadingErrorWidgets<T> on AsyncValue<T> {
  Widget whenFine(Widget Function(T data) data,
      {String? info, bool hasShimmer = false}) {
    final placeholder = hasShimmer
        ? Container(color: Colors.grey)
            .animate(onInit: (c) => c.repeat())
            .shimmer()
        : const SizedBox.shrink();
    return when(
        error: (e, __) => placeholder,
        loading: () {
          logDebug('Loading $T $info');
          return placeholder;
        },
        data: data);
  }
}

// generate a color from a string in a deterministic manner
Color stringToColor(String str, BuildContext ctx) {
  final hash = str.hashCode;
  final r = (hash & 0xFF0000) >> 16;
  final g = (hash & 0x00FF00) >> 8;
  final b = hash & 0x0000FF;
  return Color.lerp(Color.fromARGB(255, r, g, b), ctx.cs.primary, .5)!
      .withOpacity(.5);
}
