import 'package:hive_flutter/hive_flutter.dart';

abstract class Repository<T> {
  Future<T> put(T item);
  Future<void> delete();
  Future<T?> get();
}

abstract class HiveRepository<T> extends Repository<T> {
  abstract final String boxName;
  abstract final String key;
  T? syncGet();
  Stream<BoxEvent> keyObservable();
}
