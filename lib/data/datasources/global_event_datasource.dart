import 'package:delivery_app/data/models/global_event_model.dart';

abstract class GlobalEventDatasource {
  Future<List<GlobalEventModel>> getAll();
  Future<List<GlobalEventModel>> getAllActive();
  Future<GlobalEventModel?> getById(String id);
  Future<void> create(GlobalEventModel model);
  Future<void> update(String id, GlobalEventModel model);
  Future<void> delete(String id);
}
