import 'package:delivery_app/data/datasources/global_event_datasource.dart';
import 'package:delivery_app/data/datasources/global_event_datasource_impl.dart';
import 'package:delivery_app/data/mappers/global_event_mapper.dart';
import 'package:delivery_app/data/models/global_event_model.dart';
import 'package:delivery_app/domain/entities/global_event.dart';
import 'package:delivery_app/domain/repositories/global_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GlobalEventRepositoryImpl implements GlobalEventRepository {
  final GlobalEventDatasource datasource;
  final GlobalEventMapper _mapper = GlobalEventMapper();
  GlobalEventRepositoryImpl({required this.datasource});

  @override
  Future<List<GlobalEvent>> getAll() async {
    try {
      List<GlobalEventModel> list = await datasource.getAll();
      return list.map((e) => _mapper.toEntity(e)!).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GlobalEvent?> getById(String id) async {
    try {
      GlobalEventModel? model = await datasource.getById(id);
      return _mapper.toEntity(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> create(GlobalEvent event) async {
    try {
      GlobalEventModel model = _mapper.toModel(event)!;
      await datasource.create(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String id, GlobalEvent event) async {
    try {
      GlobalEventModel model = _mapper.toModel(event)!;
      await datasource.update(id, model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String id) async {
    try { await datasource.delete(id); } catch (e) { rethrow; }
  }
  
  @override
  Future<List<GlobalEvent>> getAllActive() async {
    try {
      List<GlobalEventModel> list = await datasource.getAllActive();
      return list.map((e) => _mapper.toEntity(e)!).toList();
    } catch (e) {
      rethrow;
    }
  }
}

final globalEventRepositoryProvider = Provider<GlobalEventRepository>((ref) {
  return GlobalEventRepositoryImpl(datasource: ref.read(globalEventDatasourceProvider));
});
