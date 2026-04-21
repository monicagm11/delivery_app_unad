import 'package:delivery_app/data/datasources/request_event_datasource.dart';
import 'package:delivery_app/data/datasources/request_event_datasource_impl.dart';
import 'package:delivery_app/data/models/request_event_model.dart';
import 'package:delivery_app/domain/entities/request_event.dart';
import 'package:delivery_app/domain/repositories/request_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestEventRepositoryImpl implements RequestEventRepository {
  final RequestEventDatasource datasource;
  RequestEventRepositoryImpl({required this.datasource});

  @override
  Future<List<RequestEvent>> getAll() async {
    try { return await datasource.getAll(); } catch (e) { rethrow; }
  }

  @override
  Future<List<RequestEvent>> getByCommerce(String commerceId) async {
    try { return await datasource.getByCommerce(commerceId); } catch (e) { rethrow; }
  }

  @override
  Future<RequestEvent?> getById(String id) async {
    try { return await datasource.getById(id); } catch (e) { rethrow; }
  }

  @override
  Future<void> create(RequestEventModel model) async {
    try { await datasource.create(model); } catch (e) { rethrow; }
  }

  @override
  Future<void> update(String id, RequestEventModel model) async {
    try { await datasource.update(id, model); } catch (e) { rethrow; }
  }

  @override
  Future<void> delete(String id) async {
    try { await datasource.delete(id); } catch (e) { rethrow; }
  }
}

final requestEventRepositoryProvider = Provider<RequestEventRepository>((ref) {
  return RequestEventRepositoryImpl(
      datasource: ref.read(requestEventDatasourceProvider));
});
