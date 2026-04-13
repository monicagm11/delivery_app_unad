import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:delivery_app/data/datasources/commerce_datasource.dart';
import 'package:delivery_app/data/models/commerce_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommerceDatasourceImpl extends BaseFirestoreDatasource<CommerceModel>
    implements CommerceDatasource {
  CommerceDatasourceImpl({required super.firestore})
      : super(collectionName: 'commerces');

  @override
  Future<List<CommerceModel>> getAll() async =>
      await fetchAll(CommerceModel.fromMap) ?? [];

  @override
  Future<CommerceModel?> getById(String id) async =>
      await findById(id, CommerceModel.fromMap);

  @override
  Future<void> create(CommerceModel model) async {
    try {
      final map = model.toMap();
      await add(map);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String id, CommerceModel model) async {
    try {
      final map = model.toMap();
      await updateDoc(id, map);
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

final commerceDatasourceProvider = Provider<CommerceDatasource>((ref) {
  return CommerceDatasourceImpl(firestore: ref.read(firebaseFirestoreProvider));
});
