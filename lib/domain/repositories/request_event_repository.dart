import 'package:delivery_app/domain/entities/request_event.dart';

abstract class RequestEventRepository {
  Future<List<RequestEvent>> getAll();
  Future<List<RequestEvent>> getByCommerce(String commerceId);
  Future<RequestEvent?> getById(String id);
  Future<void> create(RequestEvent model);
  Future<void> update(String id, RequestEvent model);
  Future<void> delete(String id);
}
