import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:delivery_app/data/datasources/user_datasource.dart';
import 'package:delivery_app/data/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDatasourceImpl extends BaseFirestoreDatasource<UserModel>
    implements UserDatasource {
  UserDatasourceImpl({required super.firestore})
      : super(collectionName: 'users');

  @override
  Future<List<UserModel>> getAll() async =>
      await fetchAll(UserModel.fromMap) ?? [];

  @override
  Future<UserModel?> getById(String id) async =>
      await findById(id, UserModel.fromMap);

  @override
  Future<void> create(UserModel model) async {
    try {
      await addWithId(model.userId, model.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> getByRolAndEventId(String rol, String eventId) async {
    try {
      final snapshot = await firestore
          .collection(collectionName)
          .where('rol', isEqualTo: rol)
          .where('currentEventId', isEqualTo: eventId)
          .get();
      return snapshot.docs
          .map((doc) => UserModel.fromMap({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateCurrentEventId(String id, String? eventId) async {
    try {
      await firestore
          .collection(collectionName)
          .doc(id)
          .update({'currentEventId': eventId});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String id, UserModel model) async {
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

final userDatasourceProvider = Provider<UserDatasource>((ref) {
  return UserDatasourceImpl(firestore: ref.read(firebaseFirestoreProvider));
});
