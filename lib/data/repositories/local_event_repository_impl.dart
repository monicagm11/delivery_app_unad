import 'package:delivery_app/data/datasources/local_event_datasource.dart';
import 'package:delivery_app/data/datasources/local_event_datasource_impl.dart';
import 'package:delivery_app/data/models/local_event_model.dart';
import 'package:delivery_app/domain/entities/local_event.dart';
import 'package:delivery_app/domain/repositories/local_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalEventRepositoryImpl implements LocalEventRepository {
  final LocalEventDatasource datasource;
  LocalEventRepositoryImpl({required this.datasource});

  @override
  Future<List<LocalEvent>> getAll() async {
    try {
      return await datasource.getAll();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<LocalEvent>> getByCommerce(String commerceId) async {
    try {
      return await datasource.getByCommerce(commerceId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LocalEvent?> getById(String id) async {
    try { return await datasource.getById(id); } catch (e) { rethrow; }
  }

  @override
  Future<void> create(LocalEventModel model) async {
    try { await datasource.create(model); } catch (e) { rethrow; }
  }

  @override
  Future<void> update(String id, LocalEventModel model) async {
    try { await datasource.update(id, model); } catch (e) { rethrow; }
  }

  @override
  Future<void> delete(String id) async {
    try { await datasource.delete(id); } catch (e) { rethrow; }
  }
}

final localEventRepositoryProvider = Provider<LocalEventRepository>((ref) {
  return LocalEventRepositoryImpl(datasource: ref.read(localEventDatasourceProvider));
});
