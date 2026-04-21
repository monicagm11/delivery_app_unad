import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:delivery_app/data/datasources/request_event_datasource.dart';
import 'package:delivery_app/data/models/request_event_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestEventDatasourceImpl extends BaseFirestoreDatasource<RequestEventModel>
    implements RequestEventDatasource {
  RequestEventDatasourceImpl({required super.firestore})
      : super(collectionName: 'request_events');

  @override
  Future<List<RequestEventModel>> getAll() async =>
      await fetchAll(RequestEventModel.fromMap) ?? [];

  @override
  Future<List<RequestEventModel>> getByCommerce(String commerceId) async =>
      await fetchWhere(RequestEventModel.fromMap, 'commerceId', commerceId) ?? [];

  @override
  Future<RequestEventModel?> getById(String id) async =>
      await findById(id, RequestEventModel.fromMap);

  @override
  Future<void> create(RequestEventModel model) async {
    try {
      await add(model.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String id, RequestEventModel model) async {
    try {
      await firestore.collection(collectionName).doc(id).update(model.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await firestore.collection(collectionName).doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }
}

final requestEventDatasourceProvider = Provider<RequestEventDatasource>((ref) {
  return RequestEventDatasourceImpl(firestore: ref.read(firebaseFirestoreProvider));
});
