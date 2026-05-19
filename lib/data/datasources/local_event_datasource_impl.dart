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
  Future<List<LocalEventModel>> getByCommerce(String commerceId) async =>
      await fetchWhere(LocalEventModel.fromMap, 'commerce', commerceId) ?? [];

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
  
  @override
  Future<List<LocalEventModel>> getActiveByCity(String city, String department) async {
    try {
      final snapshot = await firestore
          .collection(collectionName)
          .where('city', isEqualTo: city)
          .where('department', isEqualTo: department)
          .get();
      return snapshot.docs
          .map((doc) => LocalEventModel.fromMap({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      return [];
    }
  }
}

final localEventDatasourceProvider = Provider<LocalEventDatasource>((ref) {
  return LocalEventDatasourceImpl(firestore: ref.read(firebaseFirestoreProvider));
});
