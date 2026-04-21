import 'package:delivery_app/data/models/request_event_model.dart';

abstract class RequestEventDatasource {
  Future<List<RequestEventModel>> getAll();
  Future<List<RequestEventModel>> getByCommerce(String commerceId);
  Future<RequestEventModel?> getById(String id);
  Future<void> create(RequestEventModel model);
  Future<void> update(String id, RequestEventModel model);
  Future<void> delete(String id);
}
