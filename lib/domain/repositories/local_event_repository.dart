import 'package:delivery_app/data/models/local_event_model.dart';
import 'package:delivery_app/domain/entities/local_event.dart';

abstract class LocalEventRepository {
  Future<List<LocalEvent>> getAll();
  Future<LocalEvent?> getById(String id);
  Future<void> create(LocalEventModel model);
  Future<void> update(String id, LocalEventModel model);
  Future<void> delete(String id);
}
