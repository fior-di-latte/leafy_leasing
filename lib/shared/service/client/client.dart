import 'package:hive_flutter/hive_flutter.dart';
import 'package:leafy_leasing/shared/base.dart';

part 'hive_instance.dart';
part 'supabase_instance.dart';
part 'client.g.dart';

sealed class Client {
  Client(); // needed for inheritance
  factory Client._create() => switch (dotenv.backend) {
        (Backend.hive) => HiveInstance(),
        (Backend.supabase) => SupabaseInstance(),
      };

  int get myGeneralClientFunction => 5;
  static Future<void> initialize() => Client._create()._initialize();
  Future<void> _initialize();
}

abstract class Repository<T, ID> {
  Future<T> get(ID id);
  Future<T> put(T item, {required ID id});
  Stream<T> listenable(ID id);
}
