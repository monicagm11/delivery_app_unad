import 'package:delivery_app/domain/entities/local_event.dart';

abstract class LocalEventRepository {
  Future<List<LocalEvent>> getAll();
  Future<LocalEvent?> getById(String id);
  Future<List<LocalEvent>> getByCommerce(String commerceId);
  Future<List<LocalEvent>> getActiveByCity(String city, String department);
  Future<void> create(LocalEvent model);
  Future<void> update(String id, LocalEvent model);
  Future<void> delete(String id);
}
