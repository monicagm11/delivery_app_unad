import 'package:delivery_app/data/models/local_event_model.dart';

abstract class LocalEventDatasource {
  Future<List<LocalEventModel>> getAll();
  Future<LocalEventModel?> getById(String id);
  Future<List<LocalEventModel>> getByCommerce(String commerceId);
  Future<List<LocalEventModel>> getActiveByCity(String city, String department);
  Future<void> create(LocalEventModel model);
  Future<void> update(String id, LocalEventModel model);
  Future<void> delete(String id);
}
