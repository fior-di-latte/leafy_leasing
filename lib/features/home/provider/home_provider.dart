import 'package:leafy_leasing/features/home/model/appointment_meta.dart';
import 'package:leafy_leasing/shared/base.dart';
import 'package:leafy_leasing/shared/data_services/hive.dart';

final metasProvider = StateNotifierProvider.autoDispose<MetasNotifier,
    AsyncValue<AppointmentMetas>>(MetasNotifier.new);

class MetasNotifier extends HiveAsyncStateNotifier<AppointmentMetas> {
  MetasNotifier(AutoDisposeRef ref)
      : super(ref, boxName: hiveBoxNameMetas, key: hiveKeyMetas);
}
