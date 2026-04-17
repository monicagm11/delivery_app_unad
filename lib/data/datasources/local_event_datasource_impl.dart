import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:delivery_app/data/datasources/local_event_datasource.dart';
import 'package:delivery_app/data/models/local_event_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalEventDatasourceImpl extends BaseFirestoreDatasource<LocalEventModel>
    implements LocalEventDatasource {
  LocalEventDatasourceImpl({required super.firestore})
      : super(collectionName: 'local_events');

  @override
  Future<List<LocalEventModel>> getAll() async =>
      await fetchAll(LocalEventModel.fromMap) ?? [];

  @override
  Future<LocalEventModel?> getById(String id) async =>
      await findById(id, LocalEventModel.fromMap);

  @override
  Future<void> create(LocalEventModel model) async {
    try {
      await add(model.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String id, LocalEventModel model) async {
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

final localEventDatasourceProvider = Provider<LocalEventDatasource>((ref) {
  return LocalEventDatasourceImpl(firestore: ref.read(firebaseFirestoreProvider));
});
