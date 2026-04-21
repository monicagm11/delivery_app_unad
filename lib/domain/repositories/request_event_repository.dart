import 'package:delivery_app/data/models/request_event_model.dart';
import 'package:delivery_app/domain/entities/request_event.dart';

abstract class RequestEventRepository {
  Future<List<RequestEvent>> getAll();
  Future<List<RequestEvent>> getByCommerce(String commerceId);
  Future<RequestEvent?> getById(String id);
  Future<void> create(RequestEventModel model);
  Future<void> update(String id, RequestEventModel model);
  Future<void> delete(String id);
}
