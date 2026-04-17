import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:delivery_app/data/datasources/global_event_datasource.dart';
import 'package:delivery_app/data/models/global_event_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GlobalEventDatasourceImpl extends BaseFirestoreDatasource<GlobalEventModel>
    implements GlobalEventDatasource {
  GlobalEventDatasourceImpl({required super.firestore})
      : super(collectionName: 'global_events');

  @override
  Future<List<GlobalEventModel>> getAll() async =>
      await fetchAll(GlobalEventModel.fromMap) ?? [];

  @override
  Future<GlobalEventModel?> getById(String id) async =>
      await findById(id, GlobalEventModel.fromMap);

  @override
  Future<void> create(GlobalEventModel model) async {
    try {
      await add(model.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String id, GlobalEventModel model) async {
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

final globalEventDatasourceProvider = Provider<GlobalEventDatasource>((ref) {
  return GlobalEventDatasourceImpl(firestore: ref.read(firebaseFirestoreProvider));
});
