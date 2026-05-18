import 'package:delivery_app/domain/entities/global_event.dart';

abstract class GlobalEventRepository {
  Future<List<GlobalEvent>> getAll();
  Future<List<GlobalEvent>> getAllActive();
  Future<GlobalEvent?> getById(String id);
  Future<void> create(GlobalEvent model);
  Future<void> update(String id, GlobalEvent model);
  Future<void> delete(String id);
}
