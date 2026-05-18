import 'package:delivery_app/data/datasources/local_event_datasource.dart';
import 'package:delivery_app/data/datasources/local_event_datasource_impl.dart';
import 'package:delivery_app/data/mappers/local_event_mapper.dart';
import 'package:delivery_app/data/models/local_event_model.dart';
import 'package:delivery_app/domain/entities/local_event.dart';
import 'package:delivery_app/domain/repositories/local_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalEventRepositoryImpl implements LocalEventRepository {
  final LocalEventDatasource datasource;
  final LocalEventMapper _mapper = LocalEventMapper();
  LocalEventRepositoryImpl({required this.datasource});

  @override
  Future<List<LocalEvent>> getAll() async {
    try {
      List<LocalEventModel> list = await datasource.getAll();
      return list.map((e) => _mapper.toEntity(e)!).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<LocalEvent>> getByCommerce(String commerceId) async {
    try {
      List<LocalEventModel> list = await datasource.getByCommerce(commerceId);
      return list.map((e) => _mapper.toEntity(e)!).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LocalEvent?> getById(String id) async {
    try {
      LocalEventModel? model = await datasource.getById(id);
      return _mapper.toEntity(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> create(LocalEvent event) async {
    try {
      LocalEventModel model = _mapper.toModel(event)!;
      await datasource.create(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String id, LocalEvent event) async {
    try {
      LocalEventModel model = _mapper.toModel(event)!;
      await datasource.update(id, model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String id) async {
    try { await datasource.delete(id); } catch (e) { rethrow; }
  }
}

final localEventRepositoryProvider = Provider<LocalEventRepository>((ref) {
  return LocalEventRepositoryImpl(datasource: ref.read(localEventDatasourceProvider));
});
