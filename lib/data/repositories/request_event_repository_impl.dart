
import 'package:delivery_app/data/datasources/request_event_datasource.dart';
import 'package:delivery_app/data/datasources/request_event_datasource_impl.dart';
import 'package:delivery_app/data/mappers/request_event_mapper.dart';
import 'package:delivery_app/data/models/request_event_model.dart';
import 'package:delivery_app/domain/entities/request_event.dart';
import 'package:delivery_app/domain/repositories/request_event_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestEventRepositoryImpl implements RequestEventRepository {
  final RequestEventDatasource datasource;
  final RequestEventMapper _mapper = RequestEventMapper();
  RequestEventRepositoryImpl({required this.datasource});

  @override
  Future<List<RequestEvent>> getAll() async {
    try {
      List<RequestEventModel> list = await datasource.getAll();
      return list.map((e) => _mapper.toEntity(e)!).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<RequestEvent>> getByCommerce(String commerceId) async {
    try {
      List<RequestEventModel> list = await datasource.getByCommerce(commerceId);
      return list.map((e) => _mapper.toEntity(e)!).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RequestEvent?> getById(String id) async {
    try {
      RequestEventModel? model = await datasource.getById(id);
      return _mapper.toEntity(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> create(RequestEvent event) async {
    try {
      RequestEventModel model = _mapper.toModel(event)!;
      await datasource.create(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String id, RequestEvent event) async {
    try {
      RequestEventModel model = _mapper.toModel(event)!;
      await datasource.update(id, model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await datasource.delete(id);
    } catch (e) {
      rethrow;
    }
  }
}

final requestEventRepositoryProvider = Provider<RequestEventRepository>((ref) {
  return RequestEventRepositoryImpl(
      datasource: ref.read(requestEventDatasourceProvider));
});
