import 'package:delivery_app/data/datasources/global_event_datasource.dart';
import 'package:delivery_app/data/datasources/global_event_datasource_impl.dart';
import 'package:delivery_app/data/models/global_event_model.dart';
import 'package:delivery_app/domain/entities/global_event.dart';
import 'package:delivery_app/domain/repositories/global_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GlobalEventRepositoryImpl implements GlobalEventRepository {
  final GlobalEventDatasource datasource;
  GlobalEventRepositoryImpl({required this.datasource});

  @override
  Future<List<GlobalEvent>> getAll() async {
    try { return await datasource.getAll(); } catch (e) { rethrow; }
  }

  @override
  Future<GlobalEvent?> getById(String id) async {
    try { return await datasource.getById(id); } catch (e) { rethrow; }
  }

  @override
  Future<void> create(GlobalEventModel model) async {
    try { await datasource.create(model); } catch (e) { rethrow; }
  }

  @override
  Future<void> update(String id, GlobalEventModel model) async {
    try { await datasource.update(id, model); } catch (e) { rethrow; }
  }

  @override
  Future<void> delete(String id) async {
    try { await datasource.delete(id); } catch (e) { rethrow; }
  }
}

final globalEventRepositoryProvider = Provider<GlobalEventRepository>((ref) {
  return GlobalEventRepositoryImpl(datasource: ref.read(globalEventDatasourceProvider));
});
