import 'package:hive_flutter/hive_flutter.dart';
import 'package:leafy_leasing/shared/base.dart';

abstract class HiveRepository<T> {
  abstract final String boxName;
  Future<void> put(T item);
  Stream<BoxEvent> keyObservable(T item);
  Future<void> delete(T item);
  T? get(String key);
}

class HiveRepositoryImpl<T> implements HiveRepository<T> {
  HiveRepositoryImpl(this.boxName) : _box = Hive.box<T>(boxName);

  @override
  final String boxName;
  final Box<T> _box;

  @override
  Future<void> delete(T item) async {
    await _box.delete(item);
  }

  @override
  T? get(String key) {
    return _box.get(key);
  }

  @override
  Future<void> put(T item) async {
    await _box.put(item, item);
  }

  @override
  Stream<BoxEvent> keyObservable(T item) {
    return _box.watch(key: item);
  }
}

final hiveRepositoryProvider = Provider.family.autoDispose<HiveRepository, String>(
    (ref, boxName) => HiveRepositoryImpl(boxName));

class HiveStateNotifier<T> extends StateNotifier<T> {
  HiveStateNotifier(this.ref, {required String boxName, required this.key})
      :
        _hiveRepository = ref.read(hiveRepositoryProvider(boxName)),
        super(ref.read(hiveRepositoryProvider(boxName)).get(key) as T) {
    _hiveRepository.keyObservable(key).listen((event) {
      if (event.value != null) {
        state = event.value as T;
      }
    });
  }

  final AutoDisposeRef ref;
  final HiveRepository _hiveRepository;
  final String key;
}

final themeModeNewProvider =
    StateNotifierProvider.autoDispose<HiveStateNotifier<ThemeMode>, ThemeMode>(
        (ref) => HiveStateNotifier<ThemeMode>(
            ref, boxName: 'rofl', key: 'lol'));
