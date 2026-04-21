import 'package:delivery_app/data/models/global_event_model.dart';
import 'package:delivery_app/domain/entities/global_event.dart';

abstract class GlobalEventRepository {
  Future<List<GlobalEvent>> getAll();
  Future<List<GlobalEvent>> getAllActive();
  Future<GlobalEvent?> getById(String id);
  Future<void> create(GlobalEventModel model);
  Future<void> update(String id, GlobalEventModel model);
  Future<void> delete(String id);
}
